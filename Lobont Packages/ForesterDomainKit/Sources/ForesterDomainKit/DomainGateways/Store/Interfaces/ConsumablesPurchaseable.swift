import Foundation

public protocol ConsumablesPurchaseable {
    var transactionsStream: AsyncStream<ForesterCoins> { get }
    var transactionErrorsStream: AsyncStream<ForesterError> { get }
    func fetchConsumables() async throws -> [DisplayConsumables]
    func purchaseConsumable(with id: String) async throws -> TransactionState
}
