import UIKit
import GoogleMobileAds

final public class BannerAdViewController: UIViewController {
    private var bannerView: GADBannerView!
    private var progressView = UIActivityIndicatorView(style: .large)
    private let adID: String
    
    public init( adID: String) {
        self.adID = adID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        createBanner()
        createLoader()
    }
    
    private func createLoader() {
        view.addSubview(progressView)
        progressView.center = view.center
        progressView.startAnimating()
    }
    
    private func createBanner() {
        let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
        bannerView = GADBannerView(adSize: adSize)
        bannerView.adUnitID = adID
        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView()
    }
    
    private func addBannerViewToView() {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

// MARK: - GADBannerViewDelegate
extension BannerAdViewController: GADBannerViewDelegate {
    public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        progressView.removeFromSuperview()
    }
}
