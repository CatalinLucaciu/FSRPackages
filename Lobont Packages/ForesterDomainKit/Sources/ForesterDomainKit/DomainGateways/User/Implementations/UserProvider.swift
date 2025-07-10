import Foundation

public final class UserProvider: UserProvidable {
    private let database: UserDatabase
    
    public init(database: UserDatabase) {
        self.database = database
    }
    
    public func fetchUserData(forID userID: UserID) async throws -> User? {
        try await database.getUserData(forID: userID)
    }
}
