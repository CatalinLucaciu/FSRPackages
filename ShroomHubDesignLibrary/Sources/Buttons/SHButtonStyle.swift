//
//  SHButtonStyle.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 02.03.2025.
//

import SwiftUI
import SHUtils

// MARK: - TO DO: add shadows, make it into a viewModifier

public struct SHMainButtonStyle: ButtonStyle {
    
    let style: Style
    let isDisabled: Bool
    
    public init(
        style: Style,
        isDisabled: Bool = false
    ) {
        self.style = style
        self.isDisabled = isDisabled
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.bold16)
            .frame(height: Constants.buttonHeight)
            .frame(maxWidth: .infinity)
            .foregroundStyle(foregroundStyle(when: configuration.isPressed))
            .background(backgroundColor(when: configuration.isPressed))
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
            .overlay (
                glareEffect(when: configuration.isPressed)
            )
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

public extension SHMainButtonStyle {
    enum Style {
        case primary
        case secondary
    }
}

private extension SHMainButtonStyle {
    func backgroundColor(when isPressed: Bool) -> Color {
        let baseColor: Color
        if isDisabled {
            return SHColor.paleGrey
        }
        switch style {
        case .primary:
            baseColor = SHColor.forestGreen
        case .secondary:
            baseColor = SHColor.mistWhite
        }
        
        return isPressed ? baseColor.opacity(0.8) : baseColor
    }
    
    func foregroundStyle(when isPressed: Bool) -> some ShapeStyle {
        let baseColor: Color
        if isDisabled {
            return SHColor.black
        }
        switch style {
        case .primary:
            baseColor = SHColor.white
        case .secondary:
            baseColor = SHColor.forestGreen
        }
        
        return baseColor
    }
    
    
    @ViewBuilder
    func glareEffect(when isPressed: Bool) -> some View {
        if isPressed {
            switch style {
            case .primary:
                RoundedRectangle(cornerRadius: CornerRadius.medium)
                    .fill(SHGradient.glareEffectGradient)
                    .blendMode(.softLight)
            case .secondary:
                RoundedRectangle(cornerRadius: CornerRadius.medium)
                    .fill(SHGradient.greenGlareEffectGradient)
                    .blendMode(.hardLight)
            }
        } else {
            EmptyView()
        }
    }
}

private extension SHMainButtonStyle {
    enum Constants {
        static let buttonHeight: CGFloat = 50
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var state: LoadableState<Void, Error> = .idle

        var body: some View {
            VStack(spacing: Spacing.medium) {
                SHLoadableButton(
                    label: { Text("Primary Action") },
                    state: $state,
                    style: .primary,
                    action: {
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                    }
                )

                SHLoadableButton(
                    label: { Text("Secondary Action") },
                    state: $state,
                    style: .secondary,
                    action: {
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                    }
                )
            }
            .padding(.horizontal, Spacing.medium)
        }
    }
    return PreviewWrapper()
}
