//
//  View+Modifiers.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 05.05.2025.
//

import SwiftUI

struct ShadowedSectionCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(SHColor.white.shadow(.drop(radius: Shadow.medium)))
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
    }
}

public extension View {
    func shadowedSectionCard() -> some View {
        modifier(ShadowedSectionCard())
    }
}

struct BackButtonModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(SHColor.forestGreen)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    public func customBackButton() -> some View {
        self.modifier(BackButtonModifier())
    }
}

struct DrawerOverlayModifier: ViewModifier {
    let isPresented: Bool
    let onDismiss: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented)
                .blur(radius: isPresented ? 5 : 0)

            if isPresented {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture(perform: onDismiss)
            }
        }
    }
}

public extension View {
    func drawerOverlay(isPresented: Bool, onDismiss: @escaping () -> Void) -> some View {
        modifier(DrawerOverlayModifier(isPresented: isPresented, onDismiss: onDismiss))
    }
}
