//
//  MAXExampleViewModel.swift
//  MAXExample
//
//  Created by henry on 29/04/2022.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

protocol MAXExampleViewModelInput {
    func viewDidLoad()
}

protocol MAXExampleViewModelOutput {
    func adUnitIdGeneral() -> String
    func adUnitIdBanner() -> String
    func adUnitIdReward1() -> String
    func adUnitIdReward2() -> String
}

protocol MAXExampleViewModel: MAXExampleViewModelInput, MAXExampleViewModelOutput { }

class DefaultMAXExampleViewModel: MAXExampleViewModel {
    // MARK: - OUTPUT
    func adUnitIdGeneral() -> String {
        return "11deb620d6d1328f"
    }
    
    func adUnitIdBanner() -> String {
        return "889a3c560141d46c"
    }
    
    func adUnitIdReward1() -> String {
        return "f88b729e15541f57"
    }
    
    func adUnitIdReward2() -> String {
        return "c5bd00d98f3971fc"
    }
}

// MARK: - INPUT. View event methods
extension DefaultMAXExampleViewModel {
    func viewDidLoad() {
    }
}
