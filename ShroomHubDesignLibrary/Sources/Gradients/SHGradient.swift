//
//  File.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 02.03.2025.
//

import SwiftUI

public struct SHGradient {
    public static var glareEffectGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.5),
                Color.white.opacity(0.0)
            ],
            startPoint: .topLeading,
            endPoint: .bottomLeading)
    }
    
    public static var greenGlareEffectGradient: LinearGradient {
        LinearGradient(
            colors: [
                SHColor.forestGreen.opacity(0.7),
                SHColor.forestGreen.opacity(0.1)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
