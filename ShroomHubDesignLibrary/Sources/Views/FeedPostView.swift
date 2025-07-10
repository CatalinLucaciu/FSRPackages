//
//  FeedPostView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 25.05.2025.
//

import SwiftUI

private enum Constants {
    static let profilePicSize: CGFloat = 60
    static let mainPicutreHeight: CGFloat = 250
    static let smallImageSize: CGFloat = 16
}

public struct FeedPostConfiguration {
    let profileImageType: ImageContentType
    let postImageType: ImageContentType
    let name: String
    let subName: String
    let description: String
    
    public init(
        profileImageType: ImageContentType,
        postImageString: String,
        name: String,
        subName: String,
        description: String
    ) {
        self.profileImageType = profileImageType
        self.postImageType = .remote(URL(string: postImageString))
        self.name = name
        self.subName = subName
        self.description = description
    }
}

public struct FeedPostView<LefSubHeaderCotent: View, FooterContent: View>: View {
    @State private var isLiked: Bool = false
    @State private var likeCount: Int
    @State private var commentCount: Int
    @ViewBuilder let leftSubHeaderContent: () -> LefSubHeaderCotent
    @ViewBuilder let footerContent: () -> FooterContent
    let configuration: FeedPostConfiguration
    let likeButtonAction: () -> Void
    let commentButtonAction: () -> Void
    
    public init(
        likeCount: Int,
        commentCount: Int,
        configuration: FeedPostConfiguration,
        leftSubHeaderContent: @escaping () -> LefSubHeaderCotent,
        footerContent: @escaping () -> FooterContent,
        likeButtonAction: @escaping () -> Void,
        commentButtonAction: @escaping () -> Void
    ) {
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.configuration = configuration
        self.likeButtonAction = likeButtonAction
        self.commentButtonAction = commentButtonAction
        self.leftSubHeaderContent = leftSubHeaderContent
        self.footerContent = footerContent
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: Spacing.small) {
                header
                subHeader
                central
                footer
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, Spacing.medium)
            .padding(.vertical, Spacing.small)
        }
        .background(SHColor.mainBackground)
    }
}

// MARK: - Views
private extension FeedPostView {
    var footer: some View {
        HStack {
            footerContent()
            Spacer()
        }
    }
    
    var rightSubHeader: some View {
        HStack(spacing: Spacing.small) {
            likeButton
            commentButton
        }
    }
    
    var header: some View {
        HStack(spacing: Spacing.small) {
            leftHeader
            Spacer()
        }
    }
    
    var subHeader: some View {
        HStack(spacing: Spacing.small) {
            leftSubHeaderContent()
            Spacer()
            rightSubHeader
        }
    }
    
    var central: some View {
        VStack(alignment: .leading) {
            mainPicutre
            Text(configuration.description)
                .font(.regular14)
                .foregroundStyle(SHColor.mediumGray)
                .truncationMode(.tail)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
    }
    
    var mainPicutre: some View {
        AsyncImageRenderer(
            source: configuration.postImageType) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: Constants.mainPicutreHeight)
                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
            } fallBack: {
                Image(systemName: postPlaceholderImage)
                    .resizable()
                    .frame(height: Constants.mainPicutreHeight)
                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
            }
            .allowsHitTesting(false)
        
    }
    
    var leftHeader: some View {
        HStack(spacing: Spacing.small) {
            profilePicture
            VStack(alignment: .leading, spacing: Spacing.small) {
                Text(configuration.name)
                    .font(.bold16)
                    .foregroundStyle(SHColor.forestGreen)
                Text(configuration.subName)
                    .font(.regular12)
                    .foregroundStyle(SHColor.mediumGray)
            }
        }
    }
    
    var profilePicture: some View {
        VStack {
            AsyncImageRenderer(source: configuration.profileImageType) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.profilePicSize, height: Constants.profilePicSize)
                    .clipShape(.circle)
                    .overlay {
                        Circle()
                            .stroke(SHColor.black, lineWidth: 2)
                    }
            } fallBack: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: Constants.profilePicSize, height: Constants.profilePicSize)
                    .foregroundStyle(SHColor.mediumGray)
                    .clipShape(.circle)
                    .overlay {
                        Circle()
                            .stroke(SHColor.black, lineWidth: 2)
                    }
            }
            
        }
    }
    var likeButton: some View {
        Button {
            isLiked.toggle()
            let increment = isLiked ? 1 : -1
            likeCount += increment
            likeButtonAction()
        } label: {
            HStack {
                Image(systemName: isLiked ? likedImage : unlikedImage)
                    .foregroundStyle(SHColor.forestGreen)
                Text(String(likeCount))
                    .font(.regular12)
                    .foregroundStyle(SHColor.forestGreen)
            }
        }
        
    }
    
    var commentButton: some View {
        Button {
            commentButtonAction()
        } label: {
            HStack {
                Image(systemName: commentImage)
                    .foregroundStyle(SHColor.forestGreen)
                Text(String(commentCount))
                    .font(.regular12)
                    .foregroundStyle(SHColor.forestGreen)
            }
        }
        
    }
    
}

// MARK: - assets
private extension FeedPostView {
    var commentImage: String {
        "bubble.left"
    }
    var unlikedImage: String {
        "heart"
    }
    var likedImage: String {
        "heart.fill"
    }
    var profilePlaceholderImage: String {
        "person.fill"
    }
    var postPlaceholderImage: String {
        "photo.fill"
    }
}
