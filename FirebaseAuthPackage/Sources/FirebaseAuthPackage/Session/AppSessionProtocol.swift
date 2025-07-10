//
//  AppSessionProtocol.swift
//  FirebaseAuthPackage
//
//  Created by Catalin Lucaciu on 09.05.2025.
//

import Foundation

public protocol AppSessionProtocol: ObservableObject {
    var currentUser: FirebaseUser? { get }
    var isUserCreationFinished: Bool { get set }
}
