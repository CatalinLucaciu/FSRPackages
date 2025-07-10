import Foundation

public typealias RegisterResponse = (id: UserID, email: Email)

public protocol Registerer {
    func register(
        email: Email,
        password: Password
    ) async throws -> RegisterResponse
}
