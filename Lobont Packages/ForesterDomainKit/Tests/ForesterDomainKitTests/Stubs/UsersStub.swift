import Foundation
@testable import ForesterDomainKit

final class UsersStub {
    var users: [(email: Email, password: Password)] = []
    var databaseUsers: [UserID: User] = [:]
}
