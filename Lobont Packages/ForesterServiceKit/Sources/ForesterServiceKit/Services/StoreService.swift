import Foundation
import StoreKit
import ForesterDomainKit

public final class StoreService: ConsumablesStore {
    private var storeProducts: [Product] = []
    private var transacitonListener: Task<Void, Error>?
    public var transactionsStream = AsyncStream.makeStream(of: ForesterCoins.self)
    public var transactionErrorsStream = AsyncStream.makeStream(of: ForesterError.self)
    
    public init() {
        transacitonListener = listenForTransactions()
    }
    
    public func fetchConsumables() async throws -> [DisplayConsumables] {
        do {
            storeProducts = try await Product.products(for: StoreConsumables.allCases.map { $0.rawValue })
            return storeProducts
                .sorted { first, second in
                    first.price < second.price
                }
                .map {
                    DisplayConsumables(
                        id: $0.id,
                        name: $0.displayName,
                        description: $0.description,
                        price: $0.displayPrice,
                        reward: StoreConsumables(rawValue: $0.id)?.reward ?? 0
                    )
                }
        } catch {
            throw ForesterError.failedToLoadConsumables
        }
    }
    
    public func purchaseConsumable(with id: String) async throws -> TransactionState {
        guard let product = storeProducts.first(where: { prod in
            prod.id == id
        }) else { throw ForesterError.iapError }
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verificationResult):
                switch verificationResult {
                case .unverified:
                    throw ForesterError.iapError
                case .verified(let verifiedTransaction):
                    await verifiedTransaction.finish()
                    return .finished(getProductReward(forId: verifiedTransaction.productID) ?? 0)
                }
            case .userCancelled:
                return .cancelled
            default:
                throw ForesterError.iapError
            }
        } catch {
            throw ForesterError.iapError
        }
    }
    
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                switch result {
                case .unverified:
                    self.transactionErrorsStream.continuation.yield(.iapError)
                case .verified(let verifiedTransaction):
                    if let reward = self.getProductReward(forId: verifiedTransaction.productID) {
                        self.transactionsStream.continuation.yield(reward)
                        await verifiedTransaction.finish()
                    }
                    self.transactionErrorsStream.continuation.yield(.iapError)
                }
            }
        }
    }
    
    private func getProductReward(forId id: String) -> ForesterCoins? {
        StoreConsumables(rawValue: id)?.reward
    }
}
