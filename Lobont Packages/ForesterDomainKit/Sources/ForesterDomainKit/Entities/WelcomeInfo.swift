import Foundation
import SwiftUI

public enum WelcomeInfo: Int, CaseIterable, Identifiable, Hashable {
    case track = 0
    case earn = 1
    case plant = 2
    
    public var id: Int {
        rawValue
    }
}
