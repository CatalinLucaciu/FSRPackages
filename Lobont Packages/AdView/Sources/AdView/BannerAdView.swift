import SwiftUI

public struct BannerAdView: UIViewControllerRepresentable {
    private let adID: String
    
    public init(adID: String) {
        self.adID = adID
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        BannerAdViewController(adID: adID)
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
