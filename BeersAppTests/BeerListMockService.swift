//
//  BeerListMockService.swift
//  BeersAppTests
//
//  Created by 李祺 on 05/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import Foundation
@testable import BeersApp

class BeerListMockService {
    var beerList = [BeerListModel]()
    var beerTypes = ""
    var beerListCompletion: ((Result<[BeerListModel], APIError>) -> ())!
    var beerTypeCompletion: ((Result<String, APIError>) -> ())!
    
    func fetchTypesSuccess() {
        beerTypeCompletion(.success(beerTypes))
    }
    
    func fetchListSuccess() {
        beerListCompletion(.success(beerList))
    }
    
    func fetchBeerListFail(error: APIError) {
        beerListCompletion(.failure(error))
    }
    
    func fetchBeerTypeFail(error: APIError) {
        beerTypeCompletion(.failure(error))
    }
}

extension BeerListMockService: BeerInfoFetchable {
    
    func fetchBeerInfo(beerTpes: String, complete completionHandler: @escaping (Result<[BeerListModel], APIError>) -> Void) {
        beerListCompletion = completionHandler
    }
    
    func fetchBeerTypes(complete completionHandler: @escaping (Result<String, APIError>) -> Void) {
        beerTypeCompletion = completionHandler
    }
}

class DataGenerator {
    
    enum BeerTestDataType {
        case incomplete
        case correct
        case incorrect
    }
    
    static func fetchUsefulBeerInfo() -> [BeerListModel] {
        let fileName = "BeerList"
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let beers = try! decoder.decode([BeerListModel].self, from: data)
        return beers
    }
    
    static func finishFetchTypeInfo(_ testType: BeerTestDataType) -> String {
        switch testType {
        case .correct:
            return "5\n2 B\n5 C\n1 C\n5 C 1 C 4 B\n3 C\n5 C\n3 C 5 C 1 C\n3 C\n2 B\n5 C 1 C\n2 B\n5 C\n4 B\n5 C 4 B\n"
        case .incorrect:
            return "1\n1 B\n1 C"
        case .incomplete:
            return "2\n1 B\n1 B"
        }
    }
}
