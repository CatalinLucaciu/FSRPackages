//
//  PlayerView.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 29.03.2025.
//


import AVKit
import SwiftUI

struct PlayerView: UIViewRepresentable {
    let url: URL
    let isInverted: Bool
    
    private static let transparentPixelBufferAttributes = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
    
    class Coordinator {
        var playerLooper: AVPlayerLooper?
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> AVPlayerView {
        let playerView = AVPlayerView()
        let playerItem = AVPlayerItem(url: url)
        
        applyVideoComposition(for: playerItem)
        
        let player = AVQueuePlayer(playerItem: playerItem)
        player.actionAtItemEnd = .pause
        playerView.player = player
        
        if let playerLayer = playerView.playerLayer {
            playerLayer.videoGravity = .resizeAspect
            playerLayer.pixelBufferAttributes = Self.transparentPixelBufferAttributes
        }
        
        return playerView
    }
    
    func updateUIView(_ playerView: AVPlayerView, context: Context) {
        let currentItemUrl: URL? = (playerView.player?.currentItem?.asset as? AVURLAsset)?.url
        if currentItemUrl != url {
            let playerItem = AVPlayerItem(url: url)
            
            applyVideoComposition(for: playerItem)
            
            playerView.player?.replaceCurrentItem(with: playerItem)
        }
        playerView.player?.play()
    }
    
    // watch this for errors
    private func applyVideoComposition(for playerItem: AVPlayerItem) {
        let asset = playerItem.asset
        Task.detached {
            do {
                let composition = try await AVMutableVideoComposition.videoComposition(
                    with: asset,
                    applyingCIFiltersWithHandler: { request in
                        guard let filter = CIFilter(name: "CIMaskToAlpha") else { return }

                        filter.setValue(request.sourceImage, forKey: kCIInputImageKey)

                        guard let outputImage = filter.outputImage else { return }

                        let finalImage = isInverted
                            ? outputImage.applyingFilter("CIColorInvert")
                            : outputImage

                        request.finish(with: finalImage, context: nil)
                    }
                )

                let tracks = try await asset.loadTracks(withMediaType: .video)

                var videoSize: CGSize?

                for track in tracks {
                    let naturalSize = try await track.load(.naturalSize)
                    let preferredTransform = try await track.load(.preferredTransform)
                    videoSize = naturalSize.applying(preferredTransform)
                }

                if let videoSize {
                    await MainActor.run {
                        composition.renderSize = videoSize
                        playerItem.videoComposition = composition
                    }
                }

            } catch {
                print("Failed to apply video composition: \(error)")
            }
        }
    }
}

class AVPlayerView: UIView {
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer? {
        layer as? AVPlayerLayer
    }

    var player: AVPlayer? {
        get { playerLayer?.player }
        set { playerLayer?.player = newValue }
    }
}
