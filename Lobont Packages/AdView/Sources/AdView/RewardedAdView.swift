import SwiftUI

public struct RewardedAdView: UIViewControllerRepresentable {
    private let adID: String
    private let adLoadingCompletion: (() -> Void)
    private let adLoadingErrorCompletion: (() -> Void)
    private let adWasDismissedCompletion: (() -> Void)
    private let adFinishedWithRewardCompletion: (() -> Void)
    
    public init(
        adID: String,
        adLoadingCompletion: @escaping (() -> Void),
        adLoadingErrorCompletion: @escaping (() -> Void),
        adWasDismissedCompletion: @escaping (() -> Void),
        adFinishedWithRewardCompletion: @escaping (() -> Void)
    ) {
        self.adID = adID
        self.adLoadingCompletion = adLoadingCompletion
        self.adLoadingErrorCompletion = adLoadingErrorCompletion
        self.adWasDismissedCompletion = adWasDismissedCompletion
        self.adFinishedWithRewardCompletion = adFinishedWithRewardCompletion
    }
    
    public func makeUIViewController(context: Context) -> RewardedAdViewController {
        RewardedAdViewController(
            adID: adID,
            adLoadingCompletion: adLoadingCompletion,
            adLoadingErrorCompletion: adLoadingErrorCompletion,
            adWasDismissedCompletion: adWasDismissedCompletion,
            adFinishedWithRewardCompletion: adFinishedWithRewardCompletion
        )
    }
    
    public func updateUIViewController(_ uiViewController: RewardedAdViewController, context: Context) {}
}
