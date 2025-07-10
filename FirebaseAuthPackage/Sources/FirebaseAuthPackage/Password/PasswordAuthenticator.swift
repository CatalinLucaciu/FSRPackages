//
//  PasswordAuthenticator.swift
//  FirebaseAuthPackage
//
//  Created by Catalin Lucaciu on 15.03.2025.
//

import Foundation
import FirebaseAuth

final class PasswordAuthenticator: Sendable {
    func signIn(
        email: String, password: String
    ) async throws -> FirebaseUser {
        do {
            let credential = EmailAuthProvider.credential(withEmail: email,
                                                          password: password)
            let user = try await Auth.auth().signIn(with: credential)
            return FirebaseUser(id: user.user.uid,
                                name: user.user.displayName,
                                email: user.user.email,
                                phoneNumber: user.user.phoneNumber,
                                photoURL: user.user.photoURL)
        } catch let error as NSError {
            throw AuthError(for: error.code)
        }
    }
    
    func register(
        email: String,
        password: String
    ) async throws -> FirebaseUser {
        do {
            let user = try await Auth.auth().createUser(withEmail: email,
                                             password: password)
            return FirebaseUser(id: user.user.uid,
                                name: user.user.displayName,
                                email: user.user.email,
                                phoneNumber: user.user.phoneNumber,
                                photoURL: user.user.photoURL)
        }
         catch let error as NSError {
             throw AuthError(for: error.code)
        }
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw AuthError.failedToSignOut
        }
    }
}
