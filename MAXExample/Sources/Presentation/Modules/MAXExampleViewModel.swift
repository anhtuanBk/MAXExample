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
    
}

protocol MAXExampleViewModel: MAXExampleViewModelInput, MAXExampleViewModelOutput { }

class DefaultMAXExampleViewModel: MAXExampleViewModel {
    
    // MARK: - OUTPUT

}

// MARK: - INPUT. View event methods
extension DefaultMAXExampleViewModel {
    func viewDidLoad() {
    }
}
