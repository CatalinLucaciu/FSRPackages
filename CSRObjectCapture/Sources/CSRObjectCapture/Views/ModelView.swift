//
//  ModelView.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 29.03.2025.
//

import QuickLook
import SwiftUI
import os

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.example.CSRObjectCapture", category: "ModelView")

struct ModelView: View {
    let modelFile: URL
    let endCaptureCallback: () -> Void

    var body: some View {
        ARQuickLookController(modelFile: modelFile, endCaptureCallback: endCaptureCallback)
    }
}

private struct ARQuickLookController: UIViewControllerRepresentable {
    let modelFile: URL
    let endCaptureCallback: () -> Void

    func makeUIViewController(context: Context) -> QLPreviewControllerWrapper {
        let controller = QLPreviewControllerWrapper()
        controller.qlvc.dataSource = context.coordinator
        controller.qlvc.delegate = context.coordinator
        return controller
    }

    func makeCoordinator() -> ARQuickLookController.Coordinator {
        return Coordinator(parent: self)
    }

    func updateUIViewController(_ uiViewController: QLPreviewControllerWrapper, context: Context) {}

    class Coordinator: NSObject, QLPreviewControllerDataSource, @preconcurrency QLPreviewControllerDelegate {
        let parent: ARQuickLookController

        init(parent inParent: ARQuickLookController) {
            parent = inParent
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.modelFile as QLPreviewItem
        }
        
        func previewControllerWillDismiss(_ controller: QLPreviewController) {
            Task { @MainActor in
                logger.log("Exiting ARQL ...")
                parent.endCaptureCallback()
            }
        }
    }
}

private class QLPreviewControllerWrapper: UIViewController {
    let qlvc = QLPreviewController()
    var qlPresented = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !qlPresented {
            present(qlvc, animated: false, completion: nil)
            qlPresented = true
        }
    }
}
