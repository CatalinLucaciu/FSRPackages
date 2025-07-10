import Foundation

public typealias EmailLoginResult = (id: UserID, email: Email)
public typealias GoogleLoginResult = (name: Name, id: UserID, email: Email)
public typealias AppleLoginResult = (name: Name, id: UserID, email: Email)

public protocol Authenticator {
    func login(email: Email, password: Password) async throws -> EmailLoginResult
    func googleLogin() async throws -> GoogleLoginResult
    func appleLogin() async throws -> AppleLoginResult
}
