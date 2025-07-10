import SwiftUI

public enum UserProfilePicture {
    public enum Free: Int, CaseIterable {
        case icon1 = 1
        case icon2
        case icon3
        case icon4
        case icon5
        case icon6
        case icon7
        case icon8
        
        public var id: String {
            "f\(rawValue)"
        }
        
        public var imageResource: ImageResource {
            .init(name: id, bundle: .main)
        }
    }
    
    enum Paid: CaseIterable {
        
    }
}
