//
//  AuthService.swift
//  FirebaseAuthPackage
//
//  Created by Catalin Lucaciu on 27.02.2025.
//


import Foundation
import FirebaseAuth

public class AuthService {
    private let auth: Auth

    // Inject FirebaseAuth from the main app
    public init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }

    // MARK: - Register User
    public func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }

    // MARK: - Login User
    public func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }

    // MARK: - Logout User
    public func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }

    // MARK: - Get Current User
    public func getCurrentUser() -> User? {
        return auth.currentUser
    }
}
