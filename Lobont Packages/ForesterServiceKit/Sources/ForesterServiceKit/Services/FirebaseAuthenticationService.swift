import FirebaseAuthentication
import ForesterDomainKit

public final class FirebaseAuthenticationService: Authenticator {
    private var firebaseAuthentication = FirebaseAuthentication()
    private var errorConvertor = ErrorConverter()
    
    public init() {}
    
    public func login(email: Email, password: Password) async throws -> EmailLoginResult {
        try await errorConvertor.convertFirebaseErrorToDomain {
            let user = try await firebaseAuthentication.passwordSignIn(withEmail: email, andPassword: password)
            return (user.id, user.email)
        }
    }
    
    public func googleLogin() async throws -> GoogleLoginResult {
        try await errorConvertor.convertFirebaseErrorToDomain {
            let user = try await firebaseAuthentication.googlSignIn()
            return (user.name ?? "", user.id, user.email)
        }
    }
    
    public func appleLogin() async throws -> AppleLoginResult {
        try await errorConvertor.convertFirebaseErrorToDomain {
            let user = try await firebaseAuthentication.appleSignIn()
            return (user.name ?? "", user.id, user.email)
        }
    }
}
