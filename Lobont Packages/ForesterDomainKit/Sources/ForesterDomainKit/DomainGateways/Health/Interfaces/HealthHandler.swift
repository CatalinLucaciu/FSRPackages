import Foundation

public protocol HealthHandler {
    var isHealthKitAvailable: Bool { get }
    
    func requestAuthorization() async throws -> AuthorizationStatus
    func getStepCount(sinceDate date: Date) async throws -> StepsCount
    func getStepCount(forDate date: Date) async throws -> StepsCount
    func getWalkedDistance(sinceDate date: Date) async throws -> WalkedDistance
    func getWalkedDistance(forDate date: Date) async throws -> WalkedDistance
    func getBurnedCalories(sinceDate date: Date) async throws -> Calories
    func getBurnedCalories(forDate date: Date) async throws -> Calories
}
