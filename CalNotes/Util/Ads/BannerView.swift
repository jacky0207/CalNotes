//
//  BannerView.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-09-10.
//

import SwiftUI
import GoogleMobileAds

struct BannerView: UIViewControllerRepresentable {
    @State private var viewWidth: CGFloat = .zero
    private let bannerView = GADBannerView()
    private let adUnitID = BuildConfig.shared.bottomBannerUnitId

    func makeUIViewController(context: Context) -> some UIViewController {
        let bannerViewController = BannerViewController()
        bannerView.rootViewController = bannerViewController
        bannerView.delegate = context.coordinator
        bannerViewController.view.addSubview(bannerView)
        // Tell the bannerViewController to update our Coordinator when the ad
        // width changes.
        bannerViewController.delegate = context.coordinator

        return bannerViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard viewWidth != .zero else { return }

        bannerView.rootViewController = uiViewController
        bannerView.removeFromSuperview()
        uiViewController.view.addSubview(bannerView)
        // Request a banner ad with the updated viewWidth.
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        // Load with ad unit id
        bannerView.adUnitID = adUnitID  // banner view lost adUnitId after load()
        bannerView.load(GADRequest())
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, BannerViewControllerWidthDelegate, GADBannerViewDelegate {
        let parent: BannerView

        init(_ parent: BannerView) {
            self.parent = parent
        }

        // MARK: - BannerViewControllerWidthDelegate methods

        func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat) {
            // Pass the viewWidth from Coordinator to BannerView.
            parent.viewWidth = width
            print("\(#function) called")
        }

        // MARK: - GADBannerViewDelegate methods

        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("\(#function) called")
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("\(#function) called")
            print("error: \(error)")
        }

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {

        }

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {

        }

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {

        }

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {

        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
            .previewLayout(.sizeThatFits)
    }
}
