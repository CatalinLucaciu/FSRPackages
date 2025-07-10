//
//  PhotoLibraryPicker.swift
//  CSRImageClassifier
//
//  Created by Catalin Lucaciu on 24.05.2025.
//


import SwiftUI
import PhotosUI

public struct PhotoLibraryPicker: UIViewControllerRepresentable {
    public var onImagePicked: (UIImage) -> Void
    
    public init(onImagePicked: @escaping (UIImage) -> Void) {
        self.onImagePicked = onImagePicked
    }

    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }

    public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let onImagePicked: (UIImage) -> Void

        init(onImagePicked: @escaping (UIImage) -> Void) {
            self.onImagePicked = onImagePicked
        }

        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let result = results.first,
                  result.itemProvider.canLoadObject(ofClass: UIImage.self) else {
                return
            }

            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.onImagePicked(image)
                    }
                }
            }
        }
    }
}
