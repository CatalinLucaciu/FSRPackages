import Foundation

public protocol UserRegistrable {
    func register(
        withEmail email: Email,
        password: Password,
        name: Name
    ) async throws
}
