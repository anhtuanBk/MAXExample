//
//  MAXExampleViewController.swift
//  MAXExample
//
//  Created by henry on 29/04/2022.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import Resolver

class MAXExampleViewController: UIViewController {
    
    @Injected private var viewModel: MAXExampleViewModel
    
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
        
    }
}
