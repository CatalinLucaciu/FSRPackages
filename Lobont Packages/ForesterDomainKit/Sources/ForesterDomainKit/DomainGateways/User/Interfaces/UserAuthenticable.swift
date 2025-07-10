import Foundation

public protocol UserAuthenticable {
    func login(withEmail email: Email, password: Password) async throws -> User
    func googleLogin() async throws -> User
    func appleLogin() async throws -> User
}
