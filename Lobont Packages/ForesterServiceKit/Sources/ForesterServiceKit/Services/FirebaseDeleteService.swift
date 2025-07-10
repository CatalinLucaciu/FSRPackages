import FirebaseAuthentication
import ForesterDomainKit

public final class FirebaseDeleteService: Deleter {
    private var firebaseAuthentication = FirebaseAuthentication()
    private var errorConvertor = ErrorConverter()
    
    public init() {}
    
    public func deleteEmailAccount(forEmail email: Email, password: Password) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await firebaseAuthentication.deleteEmailUser(forEmail: email, password: password)
        }
    }
    
    public func deleteGoogleAccount() async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await firebaseAuthentication.deleteGoogleUser()
        }
    }
    
    public func deleteAppleAccount(forUserID userID: UserID) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await firebaseAuthentication.deleteAppleUser(forUserID: userID)
        }
    }
}
