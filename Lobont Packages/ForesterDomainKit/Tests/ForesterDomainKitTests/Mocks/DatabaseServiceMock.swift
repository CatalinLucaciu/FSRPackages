import Foundation
@testable import ForesterDomainKit

final class DatabaseServiceMock: UserDatabase {
    private var users: UsersStub
    
    init(users: UsersStub) {
        self.users = users
    }
    
    func getUserData(userID: UserID) async throws -> GetUserDataResponse {
        users.databaseUsers[userID]
    }
    
    func addUserData(userID: UserID, data: User) async throws {
        users.databaseUsers[userID] = data
    }
}
