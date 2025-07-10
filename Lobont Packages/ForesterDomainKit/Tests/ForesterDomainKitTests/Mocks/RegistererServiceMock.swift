import Foundation
@testable import ForesterDomainKit

final class RegistererServiceMock: Registerer {
    private var users: UsersStub
    
    init(users: UsersStub) {
        self.users = users
    }
    
    func register(email: Email, password: Password) async throws -> RegisterResponse {
        users.users.append((email, password))
        return email
    }
}
