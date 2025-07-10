import Foundation

public enum ForesterError: Error {
    case userNotFound
    case googleServicesError
    case failedToRegister
    case failedToFetchDatabaseData
    case unknownError
    case failedToResetPassword
    case failedToUpdatePassword
    case emailAlreadyInUsage
    case failedToFetchHealthKitData
    case healthKitPermissionDenied
    case failedToDeleteAccount
    case notEnoghtCoinsToPurchaseTree
    case failedToLoadAd
    case iapError
    case failedToLoadConsumables
    case appleServicesError
    case failedToLogout
}
