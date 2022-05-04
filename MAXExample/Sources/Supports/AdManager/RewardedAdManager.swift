//
//  RewardedAdManager.swift
//  MAXExample
//
//  Created by henry on 04/05/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import AppLovinSDK

class RewardedAdManager: NSObject, AdMangable, MARewardedAdDelegate {
    private var rewardedAd: MARewardedAd!
    private var retryAttempt = 0.0
    
    required init(_with adUnitId: String, retryAttempt: Double) {
        rewardedAd = MARewardedAd.shared(withAdUnitIdentifier: adUnitId)
        self.retryAttempt = retryAttempt
    }
    
    func load() {
        rewardedAd.delegate = self
        // Load the first ad
        rewardedAd.load()
    }
    
    func show() {
        if rewardedAd.isReady {
            rewardedAd.show()
        }
    }
    
    // MARK: MAAdDelegate Protocol
    
    func didLoad(_ ad: MAAd) {
        print("RewardedAd didLoad: \(ad)")
        // Rewarded ad is ready to be shown. '[self.rewardedAd isReady]' will now return 'YES'
        
        // Reset retry attempt
        retryAttempt = 0
    }
    
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        print("RewardedAd didFailToLoadAd: \(adUnitIdentifier) erorr: \(error)")
        // Rewarded ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        
        retryAttempt += 1
        let delaySec = pow(2.0, min(6.0, retryAttempt))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySec) {
            self.rewardedAd.load()
        }
    }
    
    func didDisplay(_ ad: MAAd) {
        print("RewardedAd didDisplay: \(ad)")
    }
    
    func didClick(_ ad: MAAd) {
        print("RewardedAd didClick: \(ad)")
    }
    
    func didHide(_ ad: MAAd) {
        print("RewardedAd didHide: \(ad)")
        // Rewarded ad is hidden. Pre-load the next ad
        rewardedAd.load()
    }
    
    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        print("RewardedAd didFail: \(ad) error: \(error)")
        // Rewarded ad failed to display. We recommend loading the next ad
        rewardedAd.load()
    }
    
    // MARK: MARewardedAdDelegate Protocol
    
    func didStartRewardedVideo(for ad: MAAd) {
        print("RewardedAd didStartRewardedVideo: \(ad)")
    }
    
    func didCompleteRewardedVideo(for ad: MAAd) {
        print("RewardedAd didCompleteRewardedVideo: \(ad)")
    }
    
    func didRewardUser(for ad: MAAd, with reward: MAReward) {
        // Rewarded ad was displayed and user should receive the reward
        print("RewardedAd didRewardUser: \(ad) reward: \(reward)")
    }
}
