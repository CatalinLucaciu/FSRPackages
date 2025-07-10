import Foundation

public enum IncrementableUserDatabaseFields {
    case steps(StepsCount)
    case distance(WalkedDistance)
    case calories(Calories)
    case coins(ForesterCoins)
    case plantedTrees(PlantedTrees)
    
    public var value: Int {
        switch self {
        case .steps(let steps): steps
        case .distance(let walkedDistance): walkedDistance
        case .calories(let calories): calories
        case .coins(let coins): coins
        case .plantedTrees(let plantedTrees): plantedTrees
        }
    }
    
    public var fieldName: String {
        switch self {
        case .steps: "totalSteps"
        case .distance: "totalWalkedDistance"
        case .calories: "burntCalories"
        case .coins: "coinsCount"
        case .plantedTrees: "plantedTreesCount"
        }
    }
}
