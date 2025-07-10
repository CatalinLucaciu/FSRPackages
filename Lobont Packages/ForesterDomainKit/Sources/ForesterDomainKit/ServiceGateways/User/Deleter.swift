import Foundation

public protocol Deleter {
    func deleteEmailAccount(forEmail email: Email, password: Password) async throws
    func deleteGoogleAccount() async throws
    func deleteAppleAccount(forUserID userID: UserID) async throws
}
