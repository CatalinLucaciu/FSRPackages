//
//  SuccesView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 12.05.2025.
//

import SwiftUI
import Lottie

public struct SuccesView: View {
    let animationName: String
    let succesString: String
    let loopMode: LottieLoopMode
    @State private var textAppeared: Bool = false
    @Environment(\.dismiss) private var dismiss
    let completion: (() -> Void)?
    
    
    public init(
        animationName: String,
        succesString: String,
        loopMode: LottieLoopMode,
        completion: (() -> Void)?
    ) {
        self.animationName = animationName
        self.succesString = succesString
        self.loopMode = loopMode
        self.completion = completion
    }
    
    public var body: some View {
        VStack(spacing: Spacing.medium) {
            LottieView(animation: .named(animationName))
                .playing(loopMode: loopMode)
                .animationSpeed(1.5)
                .animationDidFinish { _ in
                    dismiss()
                    completion?()
                }
            Text(succesString)
                .font(.bold20)
                .foregroundStyle(SHColor.forestGreen)
                .opacity(textAppeared ? 1 : 0)
                .offset(y: textAppeared ? 0 : 10)
                .scaleEffect(textAppeared ? 1 : 0.95)
                .animation(.spring(response: 0.5, dampingFraction: 0.75).delay(0.6), value: textAppeared)
                .onAppear {
                    textAppeared.toggle()
                }
            Spacer()
        }
        .padding(.all, Spacing.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SHColor.mainBackground)
        
    }
}
