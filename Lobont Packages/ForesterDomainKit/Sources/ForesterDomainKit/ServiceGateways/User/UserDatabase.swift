import Foundation

public typealias GetUserDataResponse = User?

public protocol UserDatabase {
    func getUserData(forID userID: UserID) async throws -> GetUserDataResponse
    func addUserData(data: User) async throws
    func deleteUser(forID userID: UserID) async throws
}
