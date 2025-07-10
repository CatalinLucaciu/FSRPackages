//
//  SHLoadableButton.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 15.03.2025.
//

import SwiftUI
import SHUtils

public struct SHLoadableButton<Value: Sendable, Label>: View where Label: View {
    @Binding var state: LoadableState<Value, Error>
    let isDisabled : Bool
    let label: Label
    let style: SHMainButtonStyle.Style
    let action: () async throws -> Void
    
    public init(@ViewBuilder label: () -> Label,
                state: Binding<LoadableState<Value, Error>>,
                style: SHMainButtonStyle.Style,
                isDisabled: Bool = false,
                action: @escaping () async throws -> Void) {
        self.label = label()
        self._state = state
        self.style = style
        self.isDisabled = isDisabled
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            Task {
                try await action()
            }
        }) {
            stateAwareLabel
        }
        .buttonStyle(SHMainButtonStyle(style: style,
                                       isDisabled: shouldDisable))
        .alert(state: $state)
    }
}

// MARK: - Utils
private extension SHLoadableButton {
    @ViewBuilder
    var stateAwareLabel: some View {
        switch state {
        case .loading:
            ProgressView()
        default:
            label
        }
    }
    
    var shouldDisable: Bool {
        switch state {
        case .loading:
            return isDisabled || true
        default:
            return isDisabled
        }
    }
}
