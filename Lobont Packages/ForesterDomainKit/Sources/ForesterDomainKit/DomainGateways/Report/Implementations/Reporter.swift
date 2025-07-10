import Foundation

public final class Reporter: Reportable {
    private let database: ReportDatabase
    
    public init(database: ReportDatabase) {
        self.database = database
    }
    
    public func reportIssue(report: Report, suggestCase: SuggestCase) async throws {
        try await database.reportIssue(report: report, suggestCase: suggestCase)
    }
}
