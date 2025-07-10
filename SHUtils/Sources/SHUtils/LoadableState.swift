//
//  LoadableState.swift
//  SHUtils
//
//  Created by Catalin Lucaciu on 15.03.2025.
//

import Foundation

public enum LoadableState<Success: Sendable, Failure: Sendable>: Equatable, Sendable {
    case idle
    case loading
    case empty
    case failure(Failure)
    case loaded(Success)
    
    public static func == (lhs: LoadableState<Success, Failure>, rhs: LoadableState<Success, Failure>) -> Bool {
        if lhs.isIdle && rhs.isIdle {
            return true
        }
        if lhs.isLoading && rhs.isLoading {
            return true
        }
        if lhs.isLoaded && rhs.isLoaded {
            return true
        }
        if lhs.isFailure && rhs.isFailure {
            return true
        }
        return false
    }
}

public extension LoadableState {
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .idle, .failure, .loaded, .empty:
            return false
        }
    }
    
    var isLoaded: Bool {
        switch self {
        case .loaded:
            return true
        case .idle, .failure, .loading, .empty:
            return false
        }
    }
    
    var isFailure: Bool {
        switch self {
        case .failure:
            return true
        case .idle, .loading, .loaded, .empty:
            return false
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .empty:
            return true
        case .idle, .loading, .loaded, .failure:
            return false
        }
    }
    
    var isIdle: Bool {
        switch self {
        case .idle:
            return true
        case .failure, .loading, .loaded, .empty:
            return false
        }
    }
    
    var value: Success? {
        switch self {
        case .idle, .loading, .failure, .empty:
            return nil
        case let .loaded(value):
            return value
        }
    }
}

public extension LoadableState {
    var failure: Failure? {
        get {
            switch self {
            case .failure(let error):
                return error
            default:
                return nil
            }
        }
        set(newFailure) {
            if let newFailure = newFailure {
                self = .failure(newFailure)
            } else {
                self = .idle
            }
        }
    }
}

public extension LoadableState where Success == Void {
    static var loaded: LoadableState {
        .loaded(())
    }
}

public extension LoadableState where Failure: Error {
    var error: Failure? {
        switch self {
        case let .failure(error):
            return error
        case .idle, .loading, .loaded, .empty:
            return nil
        }
    }
}

public extension LoadableState {
    func map<NewValue>(
        _ transform: (Success) -> NewValue
    ) -> LoadableState<NewValue, Failure> {
        switch self {
        case let .loaded(value):
            return .loaded(transform(value))
        case .idle:
            return .idle
        case .loading:
            return .loading
        case .empty:
            return .empty
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func tryMap<NewValue>(
        _ transform: (Success) throws -> NewValue
    ) throws -> LoadableState<NewValue, Failure> {
        switch self {
        case let .loaded(value):
            do {
                return .loaded(try transform(value))
            } catch {
                throw error
            }
            
        case .idle:
            return .idle
        case .loading:
            return .loading
        case .empty:
            return .empty
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func mapFailure<NewFailure>(
        _ transform: (Failure) -> NewFailure
    ) -> LoadableState<Success, NewFailure> {
        switch self {
        case let .failure(error):
            return .failure(transform(error))
        case let .loaded(value):
            return .loaded(value)
        case .idle:
            return .idle
        case .empty:
            return .empty
        case .loading:
            return .loading
        }
    }
}

public extension LoadableState where Failure == Never {
    mutating func load(
        _ operation: @escaping @Sendable () async -> Success,
        onCancel: (@Sendable () -> Void)? = nil
    ) async {
        self = .loading
        let cancellableTask = Task {
            await withTaskCancellationHandler(operation: operation) {
                onCancel?()
            }
        }
        let value = await cancellableTask.value
        if !cancellableTask.isCancelled {
            self = .loaded(value)
        }
    }
}

@MainActor
public extension LoadableState where Failure == Error {
    mutating func load(
        _ operation: @escaping () async throws -> Success,
        onCancel: (@Sendable () -> Void)? = nil
    ) async {
        self = .loading
        let cancellableTask = Task {
            try await withTaskCancellationHandler(operation: operation) {
                onCancel?()
            }
        }
        do {
            let value = try await cancellableTask.value
            if !cancellableTask.isCancelled {
                self = .loaded(value)
            }
        } catch {
            if !cancellableTask.isCancelled {
                self = .failure(error)
            }
        }
    }
}
