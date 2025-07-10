import Foundation

public final class UserUpdater: UserUpdatable {
    private let database: UserDatabase
    private let updater: Updatable
    
    public init(
        database: UserDatabase,
        updater: Updatable
    ) {
        self.database = database
        self.updater = updater
    }
    
    public func resetPassword(forEmail email: Email) async throws {
        try await updater.resetPassword(forEmail: email)
    }
    
    public func updateUserData(forID userID: UserID, field: UpdatableUserDatabaseFields) async throws {
        try await updater.updateUserData(forID: userID, field: field)
    }
    
    public func incrementUserData(forID userID: UserID, field: IncrementableUserDatabaseFields) async throws {
        try await updater.incrementUserData(forID: userID, field: field)
    }
    
    public func updateUserPassword(forEmail email: Email, oldPassword: Password, newPassword: Password) async throws {
        try await updater.updateUserPassword(forEmail: email, oldPassword: oldPassword, newPassword: newPassword)
    }
    
    public func logout() async throws {
        try await updater.logout()
    }
    
    public func googleLogout() async throws {
        try await updater.googleLogout()
    }
    
    public func appleLogout(forUserID userID: String) async throws {
        try await updater.appleLogout(forUserID: userID)
    }
}
