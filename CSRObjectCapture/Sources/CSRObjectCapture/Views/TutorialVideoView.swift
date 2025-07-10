//
//  TutorialVideoView.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 29.03.2025.
//

import SwiftUI

struct TutorialVideoView: View {
    @Environment(AppDataModel.self) var appModel
    let url: URL
    let isInReviewSheet: Bool

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            PlayerView(
                url: url,
                isInverted: (colorScheme == .light && isInReviewSheet) ? true : false
            )
            if isInReviewSheet {
                Spacer(minLength: 28)
            }
        }
        .foregroundColor(.white)
    }
}
