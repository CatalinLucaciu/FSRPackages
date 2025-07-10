//
//  View+Alert.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 16.03.2025.
//

import SwiftUI
import SHUtils

struct StateAwareAlertModifier<S>: ViewModifier where S: Sendable {
    var state: Binding<LoadableState<S, Error>>
    var retryAction: (() -> Void)?
    var confirmAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .alert(alertTitle,
                   isPresented: state.map(\.isFailure)) {
                if let retryAction {
                    Button(retryActionTitle) {
                        retryAction()
                    }
                }
                Button(alertConfirmActionTitle, role: .cancel) {
                    confirmAction?()
                }
            } message: {
                Text(state.wrappedValue.failure?.localizedDescription ?? "")
            }
    }
}

public extension View {
    // MARK: - TO DO: Expand this with other alerts when need be
    func alert<S>(state: Binding<LoadableState<S, Error>>) -> some View {
        self.modifier(StateAwareAlertModifier(state: state))
    }
    
    func alert<S>(
        state: Binding<LoadableState<S, Error>>,
        confirmAction: (() -> Void)?,
        retryAction: @escaping () -> Void
    ) -> some View
        {
            self.modifier(
                StateAwareAlertModifier(
                    state: state,
                    retryAction: retryAction,
                    confirmAction: confirmAction
                )
            )
    }
                  
}

// MARK: - Strings
private extension StateAwareAlertModifier {
    var alertTitle: String {
        "ShroomHub"
    }
    
    var alertConfirmActionTitle: String {
        "OK"
    }
    
    var retryActionTitle: String {
        "retry"
    }
}
