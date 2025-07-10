import Foundation

public protocol UserDeletable {
    func deleteEmailAccount(forEmail email: Email, password: Password, userID: UserID) async throws
    func deleteGoogleAccount(userID: UserID) async throws
    func deleteAppleAccount(userID: UserID) async throws
}
