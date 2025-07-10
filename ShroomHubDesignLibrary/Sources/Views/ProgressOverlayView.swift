//
//  ProgressOverlayView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 12.05.2025.
//

import SwiftUI

public struct ProgressOverlayView: View {
    public var body: some View {
        ZStack {
            SHColor.black.opacity(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: SHColor.white))
                .scaleEffect(1.5)
        }
    }
}
