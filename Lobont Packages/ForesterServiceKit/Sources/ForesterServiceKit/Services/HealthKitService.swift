import Foundation
import HealthKitHandler
import ForesterDomainKit

public final class HealthKitService: HealthKitServiceInterface {
    public var isHealthKitAvailable: Bool {
        hkHandler.isHealthKitAvailable
    }
    
    private let hkHandler: HealthKitHandler
    private var errorConvertor = ErrorConverter()
    
    public init(hkHandler: HealthKitHandler = HealthKitHandler()) {
        self.hkHandler = hkHandler
    }
    
    public func requestAuthorization() async throws -> AuthorizationStatus {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await hkHandler.requestAuthorization()
        }
    }
    
    public func getStepCount(sinceDate date: Date) async throws -> StepsCount {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await hkHandler.getStepCount(sinceDate: date)
        }
    }
    
    public func getStepCount(forDate date: Date) async throws -> StepsCount {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await hkHandler.getStepCount(forDate: date)
        }
    }
    
    public func getWalkedDistance(sinceDate date: Date) async throws -> WalkedDistance {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await hkHandler.getWalkedDistance(sinceDate: date)
        }
    }
    
    public func getWalkedDistance(forDate date: Date) async throws -> WalkedDistance {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await hkHandler.getWalkedDistance(forDate: date)
        }
    }
    
    public func getBurnedCalories(sinceDate date: Date) async throws -> Calories {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await hkHandler.getBurnedCalories(sinceDate: date)
        }
    }
    
    public func getBurnedCalories(forDate date: Date) async throws -> Calories {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await hkHandler.getBurnedCalories(forDate: date)
        }
    }
}
