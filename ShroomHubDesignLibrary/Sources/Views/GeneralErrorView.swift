//
//  GeneralErrorView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 25.04.2025.
//

import SwiftUI


private enum Constants {
    static let imageSize: CGFloat = 300
}

public struct GeneralErrorView: View {
    let imageName: String
    let errorMessage: String
    let completion: () -> Void
    
    public init(imageName: String,
                errorMessage: String,
                completion: @escaping () -> Void
    ) {
        self.imageName = imageName
        self.errorMessage = errorMessage
        self.completion = completion
    }
    
    public var body: some View {
        VStack(spacing: Spacing.medium) {
            Image(imageName)
                .resizable()
                .frame(width: Constants.imageSize,
                       height: Constants.imageSize)
            
            Text(errorMessage)
                .font(.bold16)
            
            Spacer()
            
            confirmButton
        }
    }
}

private extension GeneralErrorView {
    var confirmButton: some View {
        Button(action: {
            completion()
        }, label: {
            Text(buttonTitle)
        })
        .buttonStyle(SHMainButtonStyle(style: .primary))
    }
}
// MARK: - Srings
private extension GeneralErrorView {
    var buttonTitle: String {
        "Ok"
    }
}




