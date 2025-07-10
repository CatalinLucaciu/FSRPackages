//
//  File.swift
//  CSRLocationService
//
//  Created by Catalin Lucaciu on 08.05.2025.
//

import Foundation

enum LocationError: Error, LocalizedError {
    case servicesDisabled
    case notAuthorized
    case unableToFetch

    var errorDescription: String? {
        switch self {
        case .servicesDisabled:
            return "Location services are disabled on this device."
        case .notAuthorized:
            return "Location access was denied or restricted."
        case .unableToFetch:
            return "Unable to retrieve the current location."
        }
    }
}
