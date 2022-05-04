//
//  InterstitialsAdManager.swift
//  MAXExample
//
//  Created by henry on 04/05/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import AppLovinSDK

protocol AdMangable {
    init(_with adUnitId: String, retryAttempt: Double)
    func load()
    func show()
}
