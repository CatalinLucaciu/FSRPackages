//
//  AuthError.swift
//  FirebaseAuthPackage
//
//  Created by Catalin Lucaciu on 15.03.2025.
//

import Foundation
import FirebaseAuth

public enum AuthError: Error {
    case invalidEmail
    case emailAlreadyInUse
    case userNotFound
    case wrongPassword
    case networkError
    case userDisabled
    case tooManyRequests
    case weakPassword
    case missingPhoneNumber
    case invalidPhoneNumber
    case unverifiedEmail
    case unknown
    case failedToSignOut
    
    init(for errorCode: Int) {
        let authErrorCode = AuthErrorCode(rawValue: errorCode)
        switch authErrorCode {
        case .userDisabled:
            self = .userDisabled
        case .emailAlreadyInUse:
            self = .emailAlreadyInUse
        case .invalidEmail:
            self = .invalidEmail
        case .wrongPassword:
            self = .wrongPassword
        case .tooManyRequests:
            self = .tooManyRequests
        case .userNotFound:
            self = .userNotFound
        case .weakPassword:
            self = .weakPassword
        case .missingPhoneNumber:
            self = .missingPhoneNumber
        case .invalidPhoneNumber:
            self = .invalidPhoneNumber
        case .unverifiedEmail:
            self = .unverifiedEmail
        default:
            self = .unknown
        }
    }
}
