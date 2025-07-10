//
//  FeedbackView.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 29.03.2025.
//


import SwiftUI
import os

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.example.CSRObjectCapture",
                            category: "FeedbackView")

struct FeedbackView: View {
    var messageList: TimedMessageList

    var body: some View {
        VStack {
            if let activeMessage = messageList.activeMessage {
                Text("\(activeMessage.message)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .environment(\.colorScheme, .dark)
                    .transition(.opacity)
            }
        }
    }
}
