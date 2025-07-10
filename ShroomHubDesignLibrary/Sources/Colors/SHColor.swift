//
//  SHColor.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 27.02.2025.
//

import SwiftUI

public struct SHColor {
    // Primary theme colors
    public static let forestGreen = Color(hex: "#184A2C") // Deep green, main theme color
    public static let mossGreen = Color(hex: "#76B536") // Vibrant accent green
    
    // Backgrounds
    public static let mistWhite = Color(hex: "#EBFDF2") // Soft, pale background
    public static let mainBackground = Color(hex: "#F5F7F4") // Subtle warm gray-green tone
    
    // Button
    public static let paleGrey = Color(hex: "A0A0A0") // mainly used for disabled UI
    
    // General
    public static let edibleGreen = Color(hex: "#3FA34D")       // Safe to eat, friendly green
    public static let psychoactiveYellow = Color(hex: "#FFD447") // Alerting but not dangerous
    public static let toxicRed = Color(hex: "#D7263D")           // Warning, strong red for danger
    
    // Text & Neutrals
    public static let black: Color = .black // Main text color
    public static let white: Color = .white // Button Text Color
    public static let lightGray: Color = .gray.opacity(0.3)
    public static let mediumGray = Color(hex: "#6E6E6E")
}

