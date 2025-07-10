import Foundation

public enum UpdatableUserDatabaseFields {
    case name(Name)
    case profilePicture(ProfilePictureID)
    case lastSync(TimeInterval)
    case smallAdLastViewDate(TimeInterval?)
    case bigAdLastViewDate(TimeInterval?)
    
    public var value: Any? {
        switch self {
        case .name(let name): name
        case .profilePicture(let profilePictureID): profilePictureID
        case .lastSync(let timeInterval): timeInterval
        case .smallAdLastViewDate(let timeInterval): timeInterval
        case .bigAdLastViewDate(let timeInterval): timeInterval
        }
    }
    
    public var fieldName: String {
        switch self {
        case .name: "name"
        case .profilePicture: "profilePictureID"
        case .lastSync: "lastSync"
        case .smallAdLastViewDate: "smallAdLastViewDate"
        case .bigAdLastViewDate: "bigAdLastViewDate"
        }
    }
}
