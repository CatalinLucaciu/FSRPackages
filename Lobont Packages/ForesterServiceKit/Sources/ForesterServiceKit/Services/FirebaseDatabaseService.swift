import Foundation
import FirebaseDatabaseHandler
import ForesterDomainKit

public final class FirebaseDatabaseService: UserDatabase, TreesDatabase, ReportDatabase {
    private let database = FirebaseDatabaseHandler()
    private var errorConvertor = ErrorConverter()
    
    public init() {}
    
    public func getUserData(forID userID: UserID) async throws -> GetUserDataResponse {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await database.getData(
                collection: DatabaseCollections.users.rawValue,
                document: userID
            )
        }
    }
    
    public func addUserData(data: User) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await database.addData(
                collection: DatabaseCollections.users.rawValue,
                document: data.id,
                data: data
            )
        }
    }
    
    public func deleteUser(forID userID: UserID) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await database.deleteDocument(
                collection: DatabaseCollections.users.rawValue,
                document: userID
            )
        }
    }
    
    public func plantTree() async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await database.incrementField(
                collection: DatabaseCollections.trees.rawValue,
                document: TreeDatabaseValues.treesCounterDoucument,
                field: TreeDatabaseValues.treesCounterField,
                incrementValue: 1
            )
        }
    }
    
    public func getTotalNumberOfPlantedTrees() async throws -> Trees {
        try await errorConvertor.convertFirebaseErrorToDomain {
            try await database.getData(
                collection: DatabaseCollections.trees.rawValue,
                document: TreeDatabaseValues.treesCounterDoucument
            )
        }
    }
    
    public func reportIssue(report: Report, suggestCase: SuggestCase) async throws {
        try await errorConvertor.convertFirebaseErrorToDomain {
            switch suggestCase {
            case .report:
                try await database.addData(
                    collection: DatabaseCollections.reports.rawValue,
                    document: "\(report.userEmail) - \(report.title) - #\(UUID().uuidString)",
                    data: report
                )
            case .improvement:
                try await database.addData(
                    collection: DatabaseCollections.suggestions.rawValue,
                    document: "\(report.userEmail) - \(report.title) - #\(UUID().uuidString)",
                    data: report
                )
            }
        }
    }
}
