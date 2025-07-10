//
//  ClassificationError.swift
//  CSRImageClassifier
//
//  Created by Catalin Lucaciu on 11.04.2025.
//

import Foundation

public enum ClassificationError: Error, Identifiable {
    
    // MARK: Identifiable
    public var id: String {
        switch self {
        case .noResults:
            return "noResults"
        case .imageConversionFailed:
            return "imageConversionFailed"
        case .requestFailed(let message):
            // Hash the message if you don’t want to expose it verbatim
            return "requestFailed:\(message)"
        }
    }
    
    case noResults
    case requestFailed(String)
    case imageConversionFailed
}

extension ClassificationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noResults:
            return "No results found."
        case .imageConversionFailed:
            return "The image conversion has failed"
        case let .requestFailed(message):
            return message
        }
    }
}
