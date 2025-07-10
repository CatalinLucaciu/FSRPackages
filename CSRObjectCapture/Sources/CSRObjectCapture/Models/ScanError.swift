//
//  File.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 28.03.2025.
//

import Foundation

public enum ScanError: Error, LocalizedError {
    case generic
    
    public var errorDescription : String? {
        switch self {
        case .generic:
            return "Something Went Wrong"
        }
    }
}
