//
//  ScanResult.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 27.03.2025.
//

import Foundation

public enum ScanResult: Equatable {
    case success(url: URL)
    case failure(error: Error)
    case canceled
    
    public static func == (lhs: ScanResult, rhs: ScanResult) -> Bool {
        switch (lhs, rhs) {
        case let (.success(lUrl), .success(url: rUrl)):
            return lUrl == rUrl
        case let (.failure(lError), .failure(rError)):
            return String(reflecting: lError) == String(reflecting: rError)
            case (.canceled, .canceled):
            return true
        default:
            return false
        }
    }
}
