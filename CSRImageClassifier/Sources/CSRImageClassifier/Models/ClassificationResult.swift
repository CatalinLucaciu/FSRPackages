//
//  ClassificationResult.swift
//  CSRImageClassifier
//
//  Created by Catalin Lucaciu on 10.04.2025.
//

import Foundation

public struct ClassificationResult: Identifiable, Sendable, Hashable {
    public let id: UUID = UUID()
    public let label: String
    public let confidence: Float
    
    public init(label: String, confidence: Float) {
        self.label = label
        self.confidence = confidence
    }
}
