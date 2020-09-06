//
//  BeerDetailViewModel.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import Foundation

class BeerDetailViewModel {
    private var beerIntroCellModel: BeerIntroCellViewModel
    private var beerIngredientViewModel = [BeerIngredientViewModel]()
    
    init(beerDetailModel: BeerDetailModel) {
        self.beerIntroCellModel = BeerIntroCellViewModel(name: beerDetailModel.name,
                                                         description: beerDetailModel.description,
                                                         abv: beerDetailModel.abv,
                                                         imageUrl: beerDetailModel.imageUrl)
        processBeerDetails(beerDetailModel)
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
    
    func getBeerIntroCellViewModel() -> BeerIntroCellViewModel {
        return self.beerIntroCellModel
    }
    
    func getBeerDetailCellViewModel(at indexPath: IndexPath) -> IngredientDetailCellViewModel {
        return beerIngredientViewModel[indexPath.section - 1].items[indexPath.row]
    }
    
    private func processBeerDetails(_ beerDetailModel: BeerDetailModel) {
        
        var ingredientHopList = [IngredientDetailCellViewModel]()
        beerDetailModel.hops.forEach { ingredientHopList.append(IngredientDetailCellViewModel(ingredientTitle: $0.name,detail: String($0.amount.value) + " " + $0.amount.unit)) }
        
        beerIngredientViewModel.append(BeerIngredientViewModel(processTitle: "Hops", items: ingredientHopList))
        
        var ingredientMaltList = [IngredientDetailCellViewModel]()
        beerDetailModel.malts.forEach { ingredientMaltList.append(IngredientDetailCellViewModel(ingredientTitle: $0.name,detail: String($0.amount.value) + " " + $0.amount.unit)) }
        
        beerIngredientViewModel.append(BeerIngredientViewModel(processTitle: "Malts", items: ingredientMaltList))
        
        var ingredientMethodList = [IngredientDetailCellViewModel]()
        beerDetailModel.method.mashTemp.forEach { ingredientMethodList.append(IngredientDetailCellViewModel(ingredientTitle: String($0.temp.value) + " " + $0.temp.unit, detail: String($0.duration ?? 0) + " degress" )) }
        
        beerIngredientViewModel.append(BeerIngredientViewModel(processTitle: "Method", items: ingredientMethodList))
    }
}

struct BeerIntroCellViewModel {
    let name: String
    let description: String
    let abv: String
    let imageUrl: String
}

struct BeerIngredientViewModel {
    let processTitle: String
    let items: [IngredientDetailCellViewModel]
}

struct IngredientDetailCellViewModel {
    let ingredientTitle: String
    let detail: String
}
