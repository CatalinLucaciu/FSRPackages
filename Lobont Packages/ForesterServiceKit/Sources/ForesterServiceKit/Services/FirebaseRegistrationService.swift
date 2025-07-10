import FirebaseAuthentication
import ForesterDomainKit

public final class FirebaseRegistrationService: Registerer {
    private var firebaseAuthentication = FirebaseAuthentication()
    private var errorConvertor = ErrorConverter()
    
    public init() {}

    public func register(email: Email, password: Password) async throws -> RegisterResponse {
        try await errorConvertor.convertFirebaseErrorToDomain {
            let user = try await firebaseAuthentication.createUser(
                withEmail: email,
                andPassword: password
            )
            return (user.id, user.email)
        }
    }
}
