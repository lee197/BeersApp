//
//  BeerDetailModel.swift
//  BeersApp
//
//  Created by 李祺 on 06/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import Foundation

struct BeerDetailModel {
    let beerIntroModel: BeerIntroModel
    let beerProcessList: [BeerProcessModel]
}

struct BeerIntroModel {
    let name: String
    let description: String
    let abv: String
    let imageUrl: String
}

struct BeerProcessModel {
    let processTitle: String
    let items: [IngredientModel]
}

struct IngredientModel {
    let ingredientTitle: String
    let detail: String
}
