import Foundation

public protocol ConsumablesStore {
    func fetchConsumables() async throws -> [DisplayConsumables]
    func purchaseConsumable(with id: String) async throws -> TransactionState
}
