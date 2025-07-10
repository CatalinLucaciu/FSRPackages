import Foundation

public struct DisplayConsumables: Identifiable {
    public let id: String
    public let name: String
    public let description: String
    public let price: String
    public let reward: Int
    
    public init(
        id: String,
        name: String,
        description: String,
        price: String,
        reward: ForesterCoins
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.reward = reward
    }
}
