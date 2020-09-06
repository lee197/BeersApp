//
//  BeerDetailViewModel.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import Foundation

class BeerDetailViewModel {
    private var beerIntroCellModel: BeerIntroModel
    private var beerIngredientViewModel = [BeerProcessModel]()
    
    init(beerDetailModel: BeerDetailModel) {
        self.beerIntroCellModel = beerDetailModel.beerIntroModel
        self.beerIngredientViewModel = beerDetailModel.beerProcessList
    }
    
    func getNumberOfSections() -> Int { return self.beerIngredientViewModel.count + 1 }
    
    func getTitleOfSection(at index: Int) -> String {
        if index == 0 {
            return ""
        } else {
            return self.beerIngredientViewModel[index - 1].processTitle
        }
    }
    
    func getNumberOfCellsInSection(at sectionIndex: Int) -> Int {
        if sectionIndex == 0 {
            return 1
        } else {
            return self.beerIngredientViewModel[sectionIndex - 1].items.count
        }
    }
    
    func getBeerIntroCellViewModel() -> BeerIntroModel {
        return self.beerIntroCellModel
    }
    
    func getBeerDetailCellViewModel(at indexPath: IndexPath) -> IngredientModel {
        return beerIngredientViewModel[indexPath.section - 1].items[indexPath.row]
    }
}
