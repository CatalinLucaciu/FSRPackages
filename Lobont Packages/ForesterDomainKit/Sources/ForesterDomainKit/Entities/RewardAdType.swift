import Foundation

public enum RewardAdType {
    case small
    case big
    
    public var rewardCount: ForesterCoins {
        switch self {
        case .small: 250
        case .big: 500
        }
    }
}
