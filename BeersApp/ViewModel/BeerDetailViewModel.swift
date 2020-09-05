//
//  BeerDetailViewModel.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import Foundation

class BeerDetailViewModel {
    private let beerDetailModel: BeerDetailModel
    
    init(beerDetailModel: BeerDetailModel) {
        self.beerDetailModel = beerDetailModel
    }
    
    func getInfo() -> String { return self.beerDetailModel.description }
}
