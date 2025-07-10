import Foundation

public final class UserDeleter: UserDeletable {
    private let database: UserDatabase
    private let deleter: Deleter
    
    public init(
        database: UserDatabase,
        deleter: Deleter
    ) {
        self.database = database
        self.deleter = deleter
    }
    
    public func deleteEmailAccount(forEmail email: Email, password: Password, userID: UserID) async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                try await self.deleter.deleteEmailAccount(forEmail: email, password: password)
            }
            group.addTask {
                try await self.database.deleteUser(forID: userID)
            }
            try await group.waitForAll()
        }
    }
    
    public func deleteGoogleAccount(userID: UserID) async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                try await self.deleter.deleteGoogleAccount()
            }
            group.addTask {
                try await self.database.deleteUser(forID: userID)
            }
            try await group.waitForAll()
        }
    }
    
    public func deleteAppleAccount(userID: UserID) async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                try await self.deleter.deleteAppleAccount(forUserID: userID)
            }
            group.addTask {
                try await self.database.deleteUser(forID: userID)
            }
            try await group.waitForAll()
        }
    }
}
