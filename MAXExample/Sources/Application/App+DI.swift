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
        register { DefaultMAXExampleViewModel() }.implements(MAXExampleViewModel.self)
    }
}
