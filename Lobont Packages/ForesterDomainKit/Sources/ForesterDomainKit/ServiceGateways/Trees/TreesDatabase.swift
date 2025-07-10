import Foundation

public protocol TreesDatabase {
    func plantTree() async throws
    func getTotalNumberOfPlantedTrees() async throws -> Trees
}
