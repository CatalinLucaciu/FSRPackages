import Foundation

public protocol UserProvidable {
    func fetchUserData(forID userID: UserID) async throws -> User?
}
