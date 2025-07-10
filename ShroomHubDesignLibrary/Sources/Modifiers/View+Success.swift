//
//  View+Success.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 12.05.2025.
//

import SwiftUI
import SHUtils

public struct SuccessViewModifier<S: Sendable>: ViewModifier {
    @Binding var state: LoadableState<S, Error>
    @State private var shouldShowSuccesScreen: Bool = false
    let animationName: String
    let succesString: String
    var completion: (() -> Void)?
        
    public init(
        state: Binding<LoadableState<S, Error>>,
        animationName: String,
        succesString: String,
        completion: (() -> Void)?
    ) {
        self.animationName = animationName
        self.succesString = succesString
        self.completion = completion
        self._state = state
    }
    
    public func body(content: Content) -> some View {
        content
            .onChange(of: state, { _, newValue in
                if newValue.isLoaded {
                    shouldShowSuccesScreen.toggle()
                }
            })
            .fullScreenCover(isPresented: $shouldShowSuccesScreen) {
                SuccesView(
                    animationName: animationName,
                    succesString: succesString,
                    loopMode: .playOnce,
                    completion: completion
                )
            }
    }
}

public extension View {
    func succesView<S>(
        state: Binding<LoadableState<S, Error>>,
        animationName: String,
        succesString: String,
        completion: (() -> Void)? = nil
    ) -> some View {
        self.modifier(SuccessViewModifier(
            state: state,
            animationName: animationName,
            succesString: succesString,
            completion: completion)
        )
    }
}

