//
//  ScannerViewOld.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 27.03.2025.
//

import SwiftUI

struct SimpleError: Error {
    let message: String
}

public struct ScannerViewOld: View {
    @Bindable private var viewModel: ScanViewModel
    private let completion: (ScanResult) -> Void
    
    public init(viewModel: ScanViewModel,
                completion: @escaping (ScanResult) -> Void) {
        self.viewModel = viewModel
        self.completion = completion
    }
    
    public var body: some View {
        content
            .task {
                do {
                    try await viewModel.startSession()
                } catch {
                    completion(.failure(error: error))
                }
            }
    }
}

// MARK: Views
private extension ScannerViewOld {
    @ViewBuilder
    var content: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            
            VStack {
                if let message = viewModel.feedbackMessage {
                    Text(message)
                        .font(.title2)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .padding(.top, 50)
                }
                
                Spacer()
                
                stateContent
            }
        }
    }
    
    @ViewBuilder
    var stateContent: some View {
        Group {
            switch viewModel.captureState {
            case .notReady:
                Text("nu-i gata")
            case .processing:
                ProgressView()
            case .completed(let url):
                Button("Finish") {
                    completion(.success(url: url))
                }
            case .failed(let error):
                Button("Failure") {
                    completion(.failure(error: error))
                }
            default:
                EmptyView()
            }
        }
    }
}
