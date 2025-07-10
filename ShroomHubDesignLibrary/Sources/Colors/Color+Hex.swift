//
//  Color+Hex.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 02.03.2025.
//

import SwiftUI

public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: Double
        switch hex.count {
        case 6:
            (a, r, g, b) = (1,
                            Double((int >> 16) & 0xFF) / 255,
                            Double((int >> 8) & 0xFF) / 255,
                            Double(int & 0xFF) / 255)
        case 8:
            (a, r, g, b) = (Double((int >> 24) & 0xFF) / 255,
                            Double((int >> 16) & 0xFF) / 255,
                            Double((int >> 8) & 0xFF) / 255,
                            Double(int & 0xFF) / 255)
        default:
            (a, r, g, b) = (1, 0, 0, 0)
        }
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
