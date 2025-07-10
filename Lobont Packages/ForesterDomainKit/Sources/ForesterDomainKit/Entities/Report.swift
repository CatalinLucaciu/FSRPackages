import Foundation

public typealias ReportTitle = String
public typealias ReportMessage = String

public struct Report: Encodable {
    public let title: ReportTitle
    public let message: ReportMessage
    public let userEmail: Email
    
    public init(
        title: ReportTitle,
        message: ReportMessage,
        userEmail: Email
    ) {
        self.title = title
        self.message = message
        self.userEmail = userEmail
    }
}
