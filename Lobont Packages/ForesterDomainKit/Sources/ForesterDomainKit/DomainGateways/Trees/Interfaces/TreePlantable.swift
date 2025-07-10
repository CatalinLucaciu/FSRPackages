import Foundation

public protocol TreePlantable {
    func canPlantTree(forCoins coins: Int) -> Bool
    func plantTree(forID userID: UserID) async throws
    func getTotalNumberOfPlantedTrees() async throws -> Int
}
