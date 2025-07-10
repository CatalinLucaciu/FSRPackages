import GoogleMobileAds
import UIKit

public final class RewardedAdViewController: UIViewController {
    private var rewardedAd: GADRewardedAd?
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
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await loadRewardedAd()
            show()
        }
    }
    
    private func loadRewardedAd() async {
        do {
            rewardedAd = try await GADRewardedAd.load(
                withAdUnitID: adID,
                request: GADRequest()
            )
            rewardedAd?.fullScreenContentDelegate = self
            adLoadingCompletion()
        } catch {
            adLoadingErrorCompletion()
        }
    }
    
    private func show() {
        guard let rewardedAd = rewardedAd else {
            adLoadingErrorCompletion()
            return
        }
        
        rewardedAd.present(fromRootViewController: nil) { [weak self] in
            guard let self else { return }
            adFinishedWithRewardCompletion()
        }
    }
}

// MARK: - GADFullScreenContentDelegate
extension RewardedAdViewController: GADFullScreenContentDelegate {
    public func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        adWasDismissedCompletion()
    }
    
    public func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        adLoadingErrorCompletion()
    }
}
