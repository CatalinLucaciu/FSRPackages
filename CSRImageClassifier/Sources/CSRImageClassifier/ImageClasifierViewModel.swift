//
//  ImageClasifierViewModel.swift
//  CSRImageClassifier
//
//  Created by Catalin Lucaciu on 10.04.2025.
//

import Foundation
import Observation
import CoreML
import Vision

@Observable
@MainActor
public final class ImageClasifierViewModel {
    private let model: VNCoreMLModel
    
    public init(model: VNCoreMLModel) {
        self.model = model
    }
    
    public func classifyImage(
        _ image: CGImage,
        orientation: CGImagePropertyOrientation = .up,
        imageCropAndScaleOption: VNImageCropAndScaleOption = .centerCrop
    ) async throws -> [ClassificationResult] {
        let requestHandler = VNImageRequestHandler(cgImage: image,
                                                   orientation: orientation)
        return try await withCheckedThrowingContinuation { continuation in
            let request = VNCoreMLRequest(model: model) { request, error in
                if let error {
                    continuation.resume(throwing: ClassificationError.requestFailed(error.localizedDescription))
                    return
                }
                
                guard let results = request.results as? [VNClassificationObservation],
                      results.first?.confidence ?? 0.0 > 0.6 else {
                    continuation.resume(throwing: ClassificationError.noResults)
                    return
                }
                
                let mappedResults =  Array(
                    results.map {
                        ClassificationResult(
                            label: $0.identifier,
                            confidence: $0.confidence
                        )}
                        .prefix(3)
                )
                
                continuation.resume(returning: mappedResults)
            }
            
            request.imageCropAndScaleOption = imageCropAndScaleOption
            
            do {
                try requestHandler.perform([request])
            } catch {
                continuation.resume(throwing: ClassificationError.requestFailed(error.localizedDescription))
            }
        }
    }
}
