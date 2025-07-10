//
//  FirebaseUser.swift
//  FirebaseAuthPackage
//
//  Created by Catalin Lucaciu on 15.03.2025.
//

import Foundation

public struct FirebaseUser: Sendable {
    public let id: String
    public let name: String?
    public let email: String?
    public let phoneNumber: String?
    public let photoURL: URL?
}
