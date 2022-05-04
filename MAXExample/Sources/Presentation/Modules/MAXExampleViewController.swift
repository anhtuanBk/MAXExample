//
//  MAXExampleViewController.swift
//  MAXExample
//
//  Created by henry on 29/04/2022.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import Resolver
import AppLovinSDK

class MAXExampleViewController: UIViewController, Resolving {
    
    @Injected private var viewModel: MAXExampleViewModel
    lazy var interstitialAdManager: InterstitialAdManager = resolver.resolve(args: ["adUnitId": viewModel.adUnitIdGeneral(),
                                                                                    "retryAttempt": 1.0])
    lazy var rewardedAdManager1: RewardedAdManager = resolver.resolve(args: ["adUnitId": viewModel.adUnitIdReward1(),
                                                                                 "retryAttempt": 1.0])
    lazy var rewardedAdManager2: RewardedAdManager = resolver.resolve(args: ["adUnitId": viewModel.adUnitIdReward2(),
                                                                                 "retryAttempt": 1.0])
    lazy var bannerAdView: MAAdView = createAdView()
    
    class func create() -> MAXExampleViewController? {
        let vc = R.storyboard.maxExampleViewController.instantiateInitialViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func bind(to viewModel: MAXExampleViewModel) {
        interstitialAdManager.load()
        rewardedAdManager1.load()
        rewardedAdManager2.load()
        bannerAdView.loadAd()
    }
    
    private func createAdView() -> MAAdView {
        let adView = MAAdView(adUnitIdentifier: viewModel.adUnitIdBanner())
        adView.delegate = self
        
        // Banner height on iPhone and iPad is 50 and 90, respectively
        let height: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ? 90 : 50
        
        // Stretch to the width of the screen for banners to be fully functional
        let width: CGFloat = UIScreen.main.bounds.width
        
        adView.frame = CGRect(x: 0, y: 50, width: width, height: height)
        
        // Set background or background color for banners to be fully functional
        adView.backgroundColor = UIColor.red
        
        view.addSubview(adView)
        return adView
    }
    
    @IBAction func didTapShowBanner(_ sender: Any) {
        bannerAdView.isHidden = false
        bannerAdView.startAutoRefresh()
    }
    
    @IBAction func didTapShowInterstitialAd(_ sender: Any) {
        interstitialAdManager.show()
    }
    
    @IBAction func didTapShowRewardedAd1(_ sender: Any) {
        rewardedAdManager1.show()
    }
    
    @IBAction func didTapShowRewardedAd2(_ sender: Any) {
        rewardedAdManager2.show()
    }
}

// MARK: MAAdDelegate Protocol
extension MAXExampleViewController: MAAdViewAdDelegate {
    func didExpand(_ ad: MAAd) {
        print("BannerAd didExpand: \(ad)")
    }
    
    func didCollapse(_ ad: MAAd) {
        print("BannerAd didCollapse: \(ad)")
    }
    
    func didLoad(_ ad: MAAd) {
        print("BannerAd didLoad: \(ad)")
    }
    
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        print("BannerAd didFailToLoadAd: \(adUnitIdentifier) error: \(error)")
    }
    
    func didClick(_ ad: MAAd) {
        print("BannerAd didClick: \(ad)")
    }
    
    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        print("BannerAd didFail: \(ad) error: \(error)")
    }
    
    func didDisplay(_ ad: MAAd) {
        /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */
    }
    
    func didHide(_ ad: MAAd) {
        /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */
    }
}
