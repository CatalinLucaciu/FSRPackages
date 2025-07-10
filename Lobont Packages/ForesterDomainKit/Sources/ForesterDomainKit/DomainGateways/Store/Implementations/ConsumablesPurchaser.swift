import Foundation

public final class ConsumablesPurchaser: ConsumablesPurchaseable {
    private let store: ConsumablesStore
    public var transactionsStream: AsyncStream<ForesterCoins>
    public var transactionErrorsStream: AsyncStream<ForesterError>
    
    public init(
        store: ConsumablesStore,
        transactionsStream: AsyncStream<ForesterCoins>,
        transactionErrorsStream: AsyncStream<ForesterError>
    ) {
        self.store = store
        self.transactionsStream = transactionsStream
        self.transactionErrorsStream = transactionErrorsStream
    }
    
    public func fetchConsumables() async throws -> [DisplayConsumables] {
        try await store.fetchConsumables()
    }
    
    public func purchaseConsumable(with id: String) async throws -> TransactionState {
        try await store.purchaseConsumable(with: id)
    }
}
