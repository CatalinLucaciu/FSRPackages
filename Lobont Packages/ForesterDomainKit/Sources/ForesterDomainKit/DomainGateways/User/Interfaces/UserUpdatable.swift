import Foundation

public protocol UserUpdatable {
    func resetPassword(forEmail email: Email) async throws
    func updateUserData(forID userID: UserID, field: UpdatableUserDatabaseFields) async throws
    func incrementUserData(forID userID: UserID, field: IncrementableUserDatabaseFields) async throws
    func updateUserPassword(forEmail email: Email, oldPassword: Password, newPassword: Password) async throws
    func logout() async throws
    func googleLogout() async throws
    func appleLogout(forUserID userID: String) async throws
}
