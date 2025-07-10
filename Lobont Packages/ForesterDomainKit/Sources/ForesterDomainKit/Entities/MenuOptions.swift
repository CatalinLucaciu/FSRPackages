import Foundation

public enum MenuOptions: Int, CaseIterable, Identifiable {
    case smallAd
    case bigAd
    case store
    case instagram
    case report
    case suggest
    
    public var id: Int {
        rawValue
    }
}
