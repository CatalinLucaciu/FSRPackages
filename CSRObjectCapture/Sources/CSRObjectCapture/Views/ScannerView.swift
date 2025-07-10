//
//  ScannerView.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 29.03.2025.
//

import SwiftUI
import os

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.example.CSRObjectCapture", category: "ContentView")

/// The root of the SwiftUI View graph.
public struct ScannerView: View {
    @Environment(AppDataModel.self) var appModel
    
    public init() { }

    public var body: some View {
        PrimaryView()
            .onAppear(perform: {
                UIApplication.shared.isIdleTimerDisabled = true
            })
            .onDisappear(perform: {
                UIApplication.shared.isIdleTimerDisabled = false
            })
    }
}
