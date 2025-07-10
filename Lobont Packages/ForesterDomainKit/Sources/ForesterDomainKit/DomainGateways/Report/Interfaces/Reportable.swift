import Foundation

public protocol Reportable {
    func reportIssue(report: Report, suggestCase: SuggestCase) async throws
}
