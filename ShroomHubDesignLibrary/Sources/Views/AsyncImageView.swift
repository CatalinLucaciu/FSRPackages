//
//  AsyncImageView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 29.04.2025.
//

import CSRNetworkService
import SwiftUI
import SHUtils

public struct AsyncImageView<Loading: View, FallBack: View, Content: View>: View {
    let imageURL: URL
    @State private var imageState: LoadableState<Data, Error> = .idle
    @ViewBuilder var contentView: (Data) -> Content
    @ViewBuilder var fallBackView: () -> FallBack
    @ViewBuilder var loadingView: () -> Loading
    private let networkSession = NetworkService()
    
    public init(
        imageURL: URL,
        contentView: @escaping (Data) -> Content,
        fallBackView: @escaping () -> FallBack,
        loadingView: @escaping () -> Loading = { ProgressView() }
    ) {
        self.imageURL = imageURL
        self.contentView = contentView
        self.fallBackView = fallBackView
        self.loadingView = loadingView
    }
    public var body: some View {
        content
            .task {
                let networkServiceInstance = networkSession
                await $imageState.load {
                    try await networkServiceInstance.send(RawDataRequest(url: imageURL))
                }
            }
    }
}

private extension AsyncImageView {
    @ViewBuilder
    var content: some View {
        switch imageState {
        case .failure:
            fallBackView()
        case let .loaded(data):
            contentView(data)
        case let .loading:
            loadingView()
        default:
            fallBackView()
        }
    }
}
