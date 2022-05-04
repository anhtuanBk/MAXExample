//
//  InterstitialAdManager.swift
//  MAXExample
//
//  Created by henry on 04/05/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import AppLovinSDK

class InterstitialAdManager: NSObject, AdMangable, MAAdDelegate {
    private var interstitialAd: MAInterstitialAd
    private var retryAttempt: Double
    
    required init(_with adUnitId: String, retryAttempt: Double = 0) {
        interstitialAd = MAInterstitialAd(adUnitIdentifier: adUnitId)
        self.retryAttempt = retryAttempt
    }
    
    func load() {
        interstitialAd.delegate = self
        // Load the first ad
        interstitialAd.load()
    }
    
    func show() {
        if interstitialAd.isReady {
            interstitialAd.show()
        }
    }
    
    // MARK: MAAdDelegate Protocol
    
    func didLoad(_ ad: MAAd) {
        print("InterstitialAd didLoad: \(ad)")
        // Interstitial ad is ready to be shown. 'interstitialAd.isReady' will now return 'true'
        
        // Reset retry attempt
        retryAttempt = 0
    }
    
    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        print("InterstitialAd didFailToLoadAd: \(adUnitIdentifier) error: \(error)")
        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        
        retryAttempt += 1
        let delaySec = pow(2.0, min(6.0, retryAttempt))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySec) {
            self.interstitialAd.load()
        }
    }
    
    func didDisplay(_ ad: MAAd) {
        print("InterstitialAd didDisplay: \(ad)")
    }
    
    func didClick(_ ad: MAAd) {
        print("InterstitialAd didClick: \(ad)")
    }
    
    func didHide(_ ad: MAAd) {
        print("InterstitialAd didHide: \(ad)")
        // Interstitial ad is hidden. Pre-load the next ad
        interstitialAd.load()
    }
    
    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        print("InterstitialAd didFail: \(ad) error \(error)")
        // Interstitial ad failed to display. We recommend loading the next ad
        interstitialAd.load()
    }
}
