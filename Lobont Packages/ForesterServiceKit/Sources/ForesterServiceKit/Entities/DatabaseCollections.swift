import Foundation

enum DatabaseCollections: String {
    case users
    case trees
    case reports
    case suggestions
}

enum TreeDatabaseValues {
    static let treesCounterDoucument = "plantedTrees"
    static let treesCounterField = "numberOfTrees"
}
