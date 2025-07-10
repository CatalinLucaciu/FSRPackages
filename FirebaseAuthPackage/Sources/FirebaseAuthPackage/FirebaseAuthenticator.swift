//
//  FirebaseAuthenticator.swift
//  FirebaseAuthPackage
//
//  Created by Catalin Lucaciu on 15.03.2025.
//

import Firebase
import FirebaseAuth

public protocol FirebaseAuthenticating: AnyObject {
    var currentUser: FirebaseUser? { get }

    @discardableResult
    func signIn(email: String, password: String) async throws -> FirebaseUser

    func createUser(email: String, password: String) async throws -> FirebaseUser

    func signOut() async throws
}
@Observable
public class FirebaseAuthenticator: FirebaseAuthenticating {
    private let passwordAuthenticator: PasswordAuthenticator
    
    public init() {
        passwordAuthenticator = PasswordAuthenticator()
    }
    
    @discardableResult
    public func signIn(
        email: String,
        password: String
    ) async throws -> FirebaseUser {
        try await passwordAuthenticator.signIn(email: email, password: password)
    }
    
    public func createUser(
        email: String,
        password: String
    ) async throws -> FirebaseUser {
        try await passwordAuthenticator.register(email: email, password: password)
    }
    
    public func signOut() async throws {
        try await passwordAuthenticator.signOut()
    }
    
    public var currentUser: FirebaseUser? {
        Auth.auth().currentUser.map {
            FirebaseUser(
                id: $0.uid,
                name: $0.displayName,
                email: $0.email,
                phoneNumber: $0.phoneNumber,
                photoURL: $0.photoURL
            )
        }
    }
}
