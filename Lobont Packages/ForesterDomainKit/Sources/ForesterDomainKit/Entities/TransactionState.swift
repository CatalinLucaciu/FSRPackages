import Foundation

public enum TransactionState {
    case finished(ForesterCoins)
    case cancelled
}
