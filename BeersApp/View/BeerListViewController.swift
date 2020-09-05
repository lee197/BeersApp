//
//  ViewController.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
    private lazy var beerListVM = {
        return BeerListViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        beerListVM.initFetch()
    }
}

