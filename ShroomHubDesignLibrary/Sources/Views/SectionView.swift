//
//  SectionView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 05.05.2025.
//

import SwiftUI

public struct SectionView<Content: View>: View {
    @ViewBuilder let content: Content
    private let icon: ImageType
    private let title: String
    
    public init(
        title: String,
        icon: ImageType,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.icon = icon
        self.title = title
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            header
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, Spacing.small)
        .shadowedSectionCard()
    }
}

private extension SectionView {
    var header: some View {
        HStack(spacing: Spacing.small) {
            switch icon {
            case let .assets(name):
                Image(name, bundle: .main)
                    .foregroundStyle(SHColor.forestGreen)
            case let .system(name):
                Image(systemName: name)
                    .foregroundStyle(SHColor.forestGreen)
            }
            Text(title)
                .font(.bold18)
                .foregroundStyle(SHColor.forestGreen)
        }
    }
}

public extension SectionView {
    enum ImageType {
        case system(String)
        case assets(String)
    }
}
