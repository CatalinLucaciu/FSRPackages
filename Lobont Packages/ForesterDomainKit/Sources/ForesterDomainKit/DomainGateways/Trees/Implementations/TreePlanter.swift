import Foundation

public final class TreePlanter: TreePlantable {
    private let updater: Updatable
    private let database: TreesDatabase
    
    public init(
        updater: Updatable,
        database: TreesDatabase
    ) {
        self.updater = updater
        self.database = database
    }
    
    public func canPlantTree(forCoins coins: Int) -> Bool {
        coins >= AppConstants.treePrice
    }
    
    public func plantTree(forID userID: UserID) async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                try await self.database.plantTree()
            }
            group.addTask {
                try await self.updater.incrementUserData(forID: userID, field: .plantedTrees(1))
            }
            group.addTask {
                try await self.updater.incrementUserData(forID: userID, field: .coins(-AppConstants.treePrice))
            }
            try await group.waitForAll()
        }
    }
    
    public func getTotalNumberOfPlantedTrees() async throws -> Int {
        try await database.getTotalNumberOfPlantedTrees().numberOfTrees
    }
}
