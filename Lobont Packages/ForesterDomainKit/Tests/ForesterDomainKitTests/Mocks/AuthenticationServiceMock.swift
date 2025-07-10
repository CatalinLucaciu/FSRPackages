import Foundation
@testable import ForesterDomainKit

final class AuthenticationServiceMock: Authenticator {
    private var users: UsersStub
    
    init(users: UsersStub) {
        self.users = users
    }
    
    func login(email: Email, password: Password) async throws -> EmailLoginResult {
        if users.users.contains(where: { user in
            user.email == email && user.password == password
        }) {
            return email
        } else {
            throw ForesterError.userNotFound
        }
    }
    
    func googleLogin() async throws -> GoogleLoginResult {
        ("", "")
    }
}
