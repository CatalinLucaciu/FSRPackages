import Foundation

public protocol ReportDatabase {
    func reportIssue(report: Report, suggestCase: SuggestCase) async throws
}
