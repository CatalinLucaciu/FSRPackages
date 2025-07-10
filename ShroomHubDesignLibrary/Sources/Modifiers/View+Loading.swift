//
//  View+Loading.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 12.05.2025.
//

import SwiftUI
import SHUtils

public struct LoadingViewModifier<S: Sendable>: ViewModifier {
    var state: LoadableState<S, Error>
    
    public init(state: LoadableState<S, Error>) {
        self.state = state
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            if state.isLoading {
                ProgressOverlayView()
            }
        }
    }
}

public extension View {
    func loadingView<S>(state: LoadableState<S, Error>) -> some View {
        self.modifier(LoadingViewModifier(state: state))
    }
}
