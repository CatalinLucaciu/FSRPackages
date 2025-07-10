import FirebaseAuthentication
import ForesterDomainKit
import FirebaseDatabaseHandler

public final class FirebaseUpdaterService: Updatable {
    private var firebaseAuthentication = FirebaseAuthentication()
    private let database = FirebaseDatabaseHandler()
    private var errorConvertor = ErrorConverter()
    
    public init() {}
    
    public func resetPassword(forEmail email: Email) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await firebaseAuthentication.resetPassword(forEmail: email)
        }
    }
    
    public func updateUserData(forID userID: UserID, field: UpdatableUserDatabaseFields) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await database.updateField(
                collection: DatabaseCollections.users.rawValue,
                document: userID,
                field: field.fieldName,
                data: field.value as Any
            )
        }
    }
    
    public func incrementUserData(forID userID: UserID, field: IncrementableUserDatabaseFields) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await database.incrementField(
                collection: DatabaseCollections.users.rawValue,
                document: userID,
                field: field.fieldName,
                incrementValue: field.value
            )
        }
    }
    
    public func updateUserPassword(forEmail email: Email, oldPassword: Password, newPassword: Password) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await firebaseAuthentication.updatePassword(
                forEmail: email,
                oldPassword: oldPassword,
                newPassword: newPassword
            )
        }
    }
    
    public func logout() async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try firebaseAuthentication.logout()
        }
    }
    
    public func googleLogout() async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try firebaseAuthentication.googleLogout()            
        }
    }
    
    public func appleLogout(forUserID userID: String) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await firebaseAuthentication.appleLogut(forUserID: userID)
        }
    }
}
