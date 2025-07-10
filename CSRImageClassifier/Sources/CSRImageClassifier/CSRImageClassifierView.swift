//
//  CSRImageClassifierView.swift
//  CSRImageClassifier
//
//  Created by Catalin Lucaciu on 14.04.2025.
//

import SwiftUI
import CoreML
import Vision

public typealias ClassificationCallback = (Result<ClassificationPayload, ClassificationError>) -> Void

public struct CSRImageClassifierView: View {
    let viewModel: ImageClasifierViewModel
    let imageSource: ClassificationImageSource
    let onClassificationResult: ClassificationCallback
    
    public init(
        model: VNCoreMLModel,
        imageSource: ClassificationImageSource,
        onClassificationResult: @escaping ClassificationCallback
        
    ) {
        viewModel = ImageClasifierViewModel(model: model)
        self.imageSource = imageSource
        self.onClassificationResult = onClassificationResult
    }
    
    public var body: some View {
        Group {
            switch imageSource {
            case .camera:
                CameraPicker { uiImage, cgImage, orientation in
                    classify(uiImage: uiImage, cgImage: cgImage, orientation: orientation)
                }
                .ignoresSafeArea(.all)
            case .library:
                PhotoLibraryPicker { uiImage in
                    guard let cgImage = uiImage.cgImage else {
                        onClassificationResult(.failure(.imageConversionFailed))
                        return
                    }
                    classify(uiImage: uiImage, cgImage: cgImage, orientation: .up)
                }
            }
        }
    }
}

// MARK: - Utils
private extension CSRImageClassifierView {
    func classify(uiImage: UIImage, cgImage: CGImage, orientation: CGImagePropertyOrientation) {
        Task {
            do {
                let results = try await viewModel.classifyImage(cgImage, orientation: orientation)
                let payload = ClassificationPayload(image: uiImage, results: results)
                onClassificationResult(.success(payload))
            } catch let error as ClassificationError {
                onClassificationResult(.failure(error))
            }
        }
    }
}


