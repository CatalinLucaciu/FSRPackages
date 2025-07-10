//
//  MushroomFindingCell.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 13.05.2025.
//

import SwiftUI
import SHUtils

private enum Constants {
    static let imageWidth: CGFloat = 100
    static let imageHeight: CGFloat = 200
    static let textImageSize: CGFloat = 10
}

public extension MushroomFindingCell {
    struct Configuration {
        let image: ImageContentType
        let title: String
        let subtitle: String
        let preFooter: String
        let footer: String
        let preFooterImage: String
        let footerImage: String
        let action: () -> Void
        
        public init(
            image: ImageContentType,
            title: String,
            subtitle: String,
            preFooter: String,
            footer: String,
            preFooterImage: String,
            footerImage: String,
            action: @escaping () -> Void
        ) {
            self.image = image
            self.title = title
            self.subtitle = subtitle
            self.preFooter = preFooter
            self.footer = footer
            self.preFooterImage = preFooterImage
            self.footerImage = footerImage
            self.action = action
        }
    }
}

public struct MushroomFindingCell: View {
    let configuration: Configuration
    
    public init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    public var body: some View {
        VStack {
            HStack(spacing: Spacing.medium) {
                imageView
                textView
            }
            .padding(.all, Spacing.small)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .shadowedSectionCard()
        .onTapGesture {
            configuration.action()
        }
    }
}

// MARK: - Views
private extension MushroomFindingCell {
    @ViewBuilder
    var imageView: some View {
        AsyncImageRenderer(source: configuration.image) { image in
            image
                .scaledToFill()
                .frame(width: Constants.imageWidth)
                .fixedSize(horizontal: true, vertical: false)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
        } fallBack: {
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFill()
                .frame(width: Constants.imageWidth)
                .fixedSize(horizontal: true, vertical: false)
                .clipped()
                .foregroundStyle(.gray)
                .opacity(0.5)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
        }
    }
    
    @ViewBuilder
    var textView: some View {
        VStack(alignment: .leading, spacing: Spacing.tiny) {
            Text(configuration.title)
                .font(.bold18)
                .foregroundStyle(SHColor.forestGreen)
            Text(configuration.subtitle)
                .font(.regular16)
                .foregroundStyle(SHColor.mediumGray)
                .padding(.bottom, Spacing.small)
            
            VStack(alignment: .leading, spacing: Spacing.tiny) {
                textAndImage(
                    text: configuration.preFooter,
                    image: configuration.preFooterImage
                )
                textAndImage(
                    text: configuration.footer,
                    image: configuration.footerImage
                )
            }
        }
    }
    @ViewBuilder
    func textAndImage(
        text: String,
        image: String
    ) -> some View {
        HStack(spacing: Spacing.tiny) {
            Image(systemName: image)
                .resizable()
                .frame(width: Constants.textImageSize,
                       height: Constants.textImageSize)
            Text(text)
                .font(.regular14)
                .lineLimit(1)
                .foregroundStyle(SHColor.mediumGray)
        }
    }
}
