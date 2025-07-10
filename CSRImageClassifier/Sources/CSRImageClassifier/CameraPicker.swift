//
//  CameraPicker.swift
//  CSRImageClassifier
//
//  Created by Catalin Lucaciu on 11.04.2025.
//

import SwiftUI
import UIKit
import Vision

public struct CameraPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    public let onImageCaptured: (UIImage, CGImage, CGImagePropertyOrientation) -> Void
    
    public init(onImageCaptured: @escaping (UIImage, CGImage, CGImagePropertyOrientation) -> Void) {
        self.onImageCaptured = onImageCaptured
    }
    
    public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker
        
        init(parent: CameraPicker) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let uiImage = info[.originalImage] as? UIImage else {
                parent.presentationMode.wrappedValue.dismiss()
                return
            }
            
            guard let cgImage = uiImage.cgImage else {
                parent.presentationMode.wrappedValue.dismiss()
                return
            }
            
            let orientation = imageOrientationToVisionOrientation(uiImage.imageOrientation)
            parent.onImageCaptured(uiImage, cgImage, orientation)
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }

        public func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()

            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
            } else {
                picker.sourceType = .photoLibrary
            }
            picker.delegate = context.coordinator
            picker.modalPresentationStyle = .overFullScreen
            return picker
        }

        public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// MARK: - Utils

private extension CameraPicker.Coordinator {
    func imageOrientationToVisionOrientation(_ orientation: UIImage.Orientation) -> CGImagePropertyOrientation {
        switch orientation {
        case .up: return .up
        case .down: return .down
        case .left: return .left
        case .right: return .right
        case .upMirrored: return .upMirrored
        case .downMirrored: return .downMirrored
        case .leftMirrored: return .leftMirrored
        case .rightMirrored: return .rightMirrored
        @unknown default: return .up
        }
    }
}
