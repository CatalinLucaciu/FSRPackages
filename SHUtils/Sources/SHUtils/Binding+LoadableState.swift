//
//  Binding+LoadableState.swift
//  SHUtils
//
//  Created by Catalin Lucaciu on 15.03.2025.
//


import SwiftUI

@MainActor
public extension Binding {
    func load<Success>(
        _ operation: @escaping @Sendable () async -> Success,
        onCancel: (@Sendable () -> Void)? = nil
    ) async where Value == LoadableState<Success, Never> {
        wrappedValue = .loading
        await wrappedValue.load(operation, onCancel: onCancel)
    }
    
    func load<Success>(
        _ operation: @escaping () async throws -> Success,
        onCancel: (@Sendable () -> Void)? = nil
    ) async where Value == LoadableState<Success, Error> {
        wrappedValue = .loading
        await wrappedValue.load(operation, onCancel: onCancel)
    }
}
