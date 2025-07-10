//
//  AsyncImageRenderer.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 13.05.2025.
//

import SwiftUI
import SHUtils
import SDWebImageSwiftUI

public struct AsyncImageRenderer<Content: View, FallBack: View>: View {
    let source: ImageContentType
    let content: (Image) -> Content
    let fallBack: () -> FallBack
    
    public init(
        source: ImageContentType,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder fallBack: @escaping () -> FallBack) {
        self.source = source
        self.content = content
        self.fallBack = fallBack
    }
    
    public var body: some View {
        switch source {
        case .remote(let url):
            if let url {
                WebImage(url: url) { image in
                    content(
                        image
                            .resizable()
                    )
                } placeholder: {
                    fallBack()
                }
            } else {
                fallBack()
            }
        case .local(let string):
            let image = Image(string, bundle: .main)
                .resizable()
            content(image)
        }
    }
}

// MARK: - Remote
public extension AsyncImageRenderer {
    static func remote(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder fallBack: @escaping () -> FallBack
    ) -> Self {
        .init(
            source: .remote(url),
            content: content,
            fallBack: fallBack)
    }
}

// MARK: - Local
public extension AsyncImageRenderer where FallBack == EmptyView {
    static func local(
        imageName: String,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder fallBack: @escaping () -> FallBack
    ) -> Self {
        .init(
            source: .local(imageName),
            content: content,
            fallBack: { EmptyView() })
    }
}
