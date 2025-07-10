//
//  AppSession.swift
//  FirebaseAuthPackage
//
//  Created by Catalin Lucaciu on 09.05.2025.
//

import Foundation
import FirebaseAuth
import Combine

private enum StorageKeys {
    static let isUserCreationFinished = "isUserCreationFinished"
}

public final class AppSession: AppSessionProtocol {
    @Published public var isUserCreationFinished: Bool = false {
        didSet {
            UserDefaults.standard.set(isUserCreationFinished, forKey: StorageKeys.isUserCreationFinished)
        }
    }
    @Published public var currentUser: FirebaseUser?
    
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    public init() {
        self.isUserCreationFinished = UserDefaults.standard.bool(forKey: StorageKeys.isUserCreationFinished)
        listenToAuthChanges()
    }
    
    deinit {
        removeListeners()
    }
    
    private func listenToAuthChanges() {
        authStateListener = Auth.auth().addStateDidChangeListener({[weak self] _, user in
            guard let self else { return }
            if let user {
                self.currentUser = FirebaseUser(
                    id: user.uid,
                    name: user.displayName,
                    email: user.email,
                    phoneNumber: user.phoneNumber,
                    photoURL: user.photoURL
                )
            } else {
                self.currentUser = nil
                isUserCreationFinished = false
            }
        })
    }
    
    private func removeListeners() {
        if let handle = authStateListener {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
