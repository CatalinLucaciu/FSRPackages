import Foundation

public enum StoreConsumables: String, CaseIterable {
    case forestTreasure = "al.forestTreasure"
    case mysticGrove = "al.mysticGrove"
    case enchantedWoodland = "al.enchanantedWoodland"
    case emeraldCanopy = "al.emeraldCanopy"
    case whisperingPines = "al.whisperingPines"
    case secretCache = "al.forestCache"
    case ancientGrove = "al.ancientGrove"
    case fabledForest = "al.fabledForest"
    
    public var reward: ForesterCoins {
        switch self {
        case .forestTreasure: 700
        case .mysticGrove: 1500
        case .enchantedWoodland: 2500
        case .emeraldCanopy: 3500
        case .whisperingPines: 4500
        case .secretCache: 5500
        case .ancientGrove: 6500
        case .fabledForest: 12000
        }
    }
}
