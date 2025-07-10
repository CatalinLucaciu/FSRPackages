import Foundation

public final class Health: HealthHandler {
    public var isHealthKitAvailable: Bool {
        hkService.isHealthKitAvailable
    }
    
    private let hkService: HealthKitServiceInterface
    
    public init(hkService: HealthKitServiceInterface) {
        self.hkService = hkService
    }
    
    public func requestAuthorization() async throws -> AuthorizationStatus {
        try await hkService.requestAuthorization()
    }
    
    public func getStepCount(sinceDate date: Date) async throws -> StepsCount {
        try await hkService.getStepCount(sinceDate: date)
    }
    
    public func getStepCount(forDate date: Date) async throws -> StepsCount {
        try await hkService.getStepCount(forDate: date)
    }
    
    public func getWalkedDistance(sinceDate date: Date) async throws -> WalkedDistance {
        try await hkService.getWalkedDistance(sinceDate: date)
    }
    
    public func getWalkedDistance(forDate date: Date) async throws -> WalkedDistance {
        try await hkService.getWalkedDistance(forDate: date)
    }
    
    public func getBurnedCalories(sinceDate date: Date) async throws -> Calories {
        try await hkService.getBurnedCalories(sinceDate: date)
    }
    
    public func getBurnedCalories(forDate date: Date) async throws -> Calories {
        try await hkService.getBurnedCalories(forDate: date)
    }
}
