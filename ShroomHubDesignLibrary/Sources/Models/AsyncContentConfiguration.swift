//
//  AsyncContentConfiguration.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 13.05.2025.
//

import SwiftUI
import SHUtils
import SDWebImageSwiftUI

public struct AsyncContentConfiguration<Content: View, FallBack: View> {
    let imageUrl: URL
    @ViewBuilder var contentView: (Image) -> Content
    @ViewBuilder var fallBackView: () -> FallBack
    
    public init(
        imageUrl: URL,
        contentView: @escaping (Image) -> Content,
        fallBackView: @escaping () -> FallBack
    ) {
        self.imageUrl = imageUrl
        self.contentView = contentView
        self.fallBackView = fallBackView
    }
}
