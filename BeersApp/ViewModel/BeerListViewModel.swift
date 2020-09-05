//
//  BeerListViewModel.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import Foundation

enum UserAlertError:  String, Error {
    case userError = "Please make sure your network is working fine or re-launch the app"
    case serverError = "Please wait a while and re-launch the app"
    case interestsConflict = "We can't make the beer to satisfy all the customers"
}

class BeerListViewModel {
    private let apiClient: BeerInfoFetchable
    var showAlertClosure: (()->())?
    var alertMessage: String? {
        didSet {
            showAlertClosure?()
        }
    }
    private var cellViewModels: [BeerListCellViewModel] = [] {
        didSet {
            reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (()->())?
    private var beerTypes = [String]()
    private var beerList = [BeerModel]()
    
    init(apiClient:BeerInfoFetchable = BeerInfoFetcher()) {
        self.apiClient = apiClient
    }
    
    func initFetch() {
        apiClient.fetchBeerTypes { [weak self] result in
            guard let self = self else { return }
            do {
                let interests = try result.get()
                self.fetchBeerList(interests)
            } catch {
                self.alertMessage = UserAlertError.serverError.rawValue
            }
        }
    }
    func getNumberOfCells() -> Int {
        return cellViewModels.count
    }
    func getCellViewModel( at indexPath: IndexPath ) -> BeerListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    private func fetchBeerList(_ interests: String) {
        let beerTypeProcessor = BeerTypeProcessor(inputStr: interests)
        let test = beerTypeProcessor.generateBeerTypes()
        if test == "No solution exists" {
            self.alertMessage = UserAlertError.interestsConflict.rawValue
            return
        }
        let reqPara = self.createParameters(typeStr: test)
        
        self.apiClient.fetchBeerInfo(beerTpes: reqPara) { [weak self] result in
            guard let self = self else { return }
            do {
                self.beerList = try result.get()
                self.processBeerInfoCellVM()
            } catch {
                self.alertMessage = UserAlertError.serverError.rawValue
            }
        }
    }
    
    private func createParameters(typeStr: String) -> String {
        self.beerTypes = typeStr.split(separator: " ").map {
            if $0 == "C" {
                return "Classic"
            } else {
                return "Barrel Aged"
            }
        }
        
        let total = beerTypes.count
        var parameterStr = ""
        for i in 1 ... total { parameterStr += String(i) + "|" }
        return parameterStr
    }
    
    private func processBeerInfoCellVM() {
        var cellViewModels = beerList.map { BeerListCellViewModel(name: $0.name,
                                                                  imageUrl: $0.imageURL,
                                                                  abv: String($0.abv))
        }
        
        for i in 0 ... self.beerTypes.count - 1 {
            cellViewModels[i].type = self.beerTypes[i]
        }
        
        self.cellViewModels = cellViewModels
    }
}

extension BeerListViewModel {
    // output
    func userPressedCell(at index: IndexPath) -> BeerDetailModel {
        let beerInfo = self.beerList[index.row]
        let beerDetailModel = BeerDetailModel(name: beerInfo.name,
                                              imageUrl: beerInfo.imageURL,
                                              abv: String(beerInfo.abv),
                                              description: beerInfo.beerModelDescription,
                                              hops: beerInfo.ingredients.hops,
                                              malts: beerInfo.ingredients.malt,
                                              method: beerInfo.method)
        return beerDetailModel
    }
}

struct BeerListCellViewModel {
    let name: String
    let imageUrl: String
    let abv: String
    var type = "Classic"
}

struct BeerDetailModel {
    let name, imageUrl, abv, description: String
    let hops: [Hop]
    let malts: [Malt]
    let method: Method
}
