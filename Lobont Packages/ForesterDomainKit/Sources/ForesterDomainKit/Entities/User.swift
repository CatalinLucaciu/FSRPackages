import Foundation

public typealias UserID = String
public typealias Email = String
public typealias Password = String
public typealias Name = String
public typealias ProfilePictureID = String
public typealias StepsCount = Int
public typealias WalkedDistance = Int
public typealias Calories = Int
public typealias PlantedTrees = Int
public typealias ForesterCoins = Int

public struct User: Codable, Hashable {
    public let id: UserID
    public var name: Name
    public let email: Email
    public var profilePictureID: ProfilePictureID
    public var totalSteps: StepsCount
    public var lastSync: TimeInterval
    public var accountCreationTime: TimeInterval
    public var totalWalkedDistance: WalkedDistance
    public var burntCalories: Calories
    public var plantedTreesCount: PlantedTrees
    public var coinsCount: ForesterCoins
    public let authenticationType: AuthenticationType
    public var smallAdLastViewDate: TimeInterval?
    public var bigAdLastViewDate: TimeInterval?
}
