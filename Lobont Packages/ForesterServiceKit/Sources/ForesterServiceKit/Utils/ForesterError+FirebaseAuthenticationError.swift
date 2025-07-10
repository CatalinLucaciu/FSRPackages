import Foundation
import ForesterDomainKit
import FirebaseAuthentication
import FirebaseDatabaseHandler
import HealthKitHandler

final class ErrorConverter {
    func convertFirebaseErrorToDomain<T>(_ asyncCode: () async throws -> T) async rethrows -> T {
        do {
            return try await asyncCode()
        } catch let error as FirebaseAuthenticationError {
            throw handleFirebaseAuthenticationError(error)
        } catch let error as FirebaseDatabaseError {
            throw handleFirebaseDatabaseError(error)
        } catch let error as HKHError {
            throw handleHealthKitError(error)
        } catch {
            throw ForesterError.unknownError
        }
    }

    private func handleFirebaseAuthenticationError(_ error: FirebaseAuthenticationError) -> ForesterError {
        switch error {
        case .noClientID: .userNotFound
        case .failedToPresentGoogleView: .googleServicesError
        case .noUserToken: .userNotFound
        case .failedToAuthenticate: .userNotFound
        case .failedToCreateUser: .failedToRegister
        case .failedToCreateGoogleUser: .googleServicesError
        case .failedToResetPassword: .failedToResetPassword
        case .failedToUpdatePassword: .failedToUpdatePassword
        case .userAlreadyRegistered: .emailAlreadyInUsage
        case .failedToDeleteAccount: .failedToDeleteAccount
        case .incorrectAuthenticationDetails: .userNotFound
        case .failedToCreateAppleUser: .appleServicesError
        case .invalidAppleNonce: .appleServicesError
        case .failedToLogout: .failedToLogout
        }
    }

    private func handleFirebaseDatabaseError(_ error: FirebaseDatabaseError) -> ForesterError {
        switch error {
        case .failedToEncodeData: .userNotFound
        case .failedToFetchData: .userNotFound
        case .failedToUpdateField: .userNotFound
        case .failedToCreateDatabaseEntry: .userNotFound
        case .failedToDeleteDocument: .userNotFound
        }
    }
    
    private func handleHealthKitError(_ error: HKHError) -> ForesterError {
        switch error {
        case .failedToRequestHealthKitAuthorization: .healthKitPermissionDenied
        case .failedToReadHealthKitSteps: .failedToFetchHealthKitData
        case .failedToReadHealthKitWalkedDistance: .failedToFetchHealthKitData
        case .failedToReadHealthKitBurntCalories: .failedToFetchHealthKitData
        case .unknwonHealthKitIdentifier: .failedToFetchHealthKitData
        }
    }
}
