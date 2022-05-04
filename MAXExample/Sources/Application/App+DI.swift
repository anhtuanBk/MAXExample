//
//  App+DI.swift
//  MAXExample
//
//  Created by henry on 29/04/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        register { DefaultMAXExampleViewModel() }.implements(MAXExampleViewModel.self)
        register { _, args in
            InterstitialAdManager(_with: args("adUnitId"), retryAttempt: args("retryAttempt"))
        }
        register { _, args in
            RewardedAdManager(_with: args("adUnitId"), retryAttempt: args("retryAttempt"))
        }
    }
}
