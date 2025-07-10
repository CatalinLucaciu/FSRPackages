//
//  TextInputView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 21.05.2025.
//

import SwiftUI

private enum Constants {
    static let editorHeight: CGFloat = 150
    static let charactersLimit: Int = 200
}

public struct TextInputView: View {
    @Environment(\.dismiss) private var dismiss
    let onInput: (String) -> Void
    @State private var message: String = ""
    @State private var isButtonEnabled: Bool = false
    
    public init(onInput: @escaping (String) -> Void) {
        self.onInput = onInput
    }
    
    public var body: some View {
        VStack(spacing: Spacing.medium) {
            Text(title)
                .font(.bold16)
                .foregroundStyle(SHColor.forestGreen)
            TextEditor(text: $message)
                .font(.regular12)
                .frame(height: Constants.editorHeight)
                .padding(Spacing.small)
                .overlay(RoundedRectangle(cornerRadius: CornerRadius.medium).stroke(SHColor.mistWhite))
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                .onAppear {
                     UITextView.appearance().backgroundColor = .clear
                 }
                .onChange(of: message) { newValue in
                    if newValue.count > Constants.charactersLimit {
                        message = String(newValue.prefix(Constants.charactersLimit))
                    }
                    isButtonEnabled = !newValue.isEmpty
                }
            
            Button(postButtonTitle) {
                onInput(message)
                dismiss()
            }
            .buttonStyle(SHMainButtonStyle(style: .primary, isDisabled: false))
        }
    }
}

// MARK: - String
private extension TextInputView {
    var postButtonTitle: String {
        "Post"
    }
    var title: String {
        "Add your coment"
    }
}
