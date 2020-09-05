//
//  BeerListViewModelTest.swift
//  BeersAppTests
//
//  Created by 李祺 on 05/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import XCTest
@testable import BeersApp

class BeerListViewModelTest: XCTestCase {
    var viewModel: BeerListViewModel!
    fileprivate var mockingFetchingService: BeerListMockService!
    
    override func setUp() {
        self.mockingFetchingService = BeerListMockService()
        self.viewModel = BeerListViewModel(apiClient: mockingFetchingService)
    }

    override func tearDown() {
        self.mockingFetchingService = nil
        self.viewModel = nil
    }
    
    func testFetchBeerTypesAndListSuccess() {
        mockingFetchingService.beerTypes = DataGenerator.finishFetchTypeInfo(.correct)
        let beerList = DataGenerator.finishFetchBeerInfo()
        mockingFetchingService.beerList = beerList
            
        let index = IndexPath(row: 0, section: 0)
        
        viewModel.initFetch()
        mockingFetchingService.fetchTypesSuccess()
        mockingFetchingService.fetchListSuccess()
        
        XCTAssertEqual(viewModel.getCellViewModel(at: index).name, beerList[0].name)
    }
    
    func testFetchBeerTypesFailed() {
        let userError = UserAlertError.serverError
        let error = APIError.dataDecodingError
        
        viewModel.initFetch()
        mockingFetchingService.fetchBeerTypeFail(error: error)
        
        XCTAssertEqual(viewModel.alertMessage, userError.rawValue)
    }
    
    func testFetchBeerListFailed() {
        mockingFetchingService.beerTypes = DataGenerator.finishFetchTypeInfo(.correct)

        let userError = UserAlertError.serverError
        let error = APIError.dataDecodingError
        
        viewModel.initFetch()
        mockingFetchingService.fetchTypesSuccess()
        mockingFetchingService.fetchBeerListFail(error: error)
        
        XCTAssertEqual(viewModel.alertMessage, userError.rawValue)
    }
    
    func testNoSolution() {
        mockingFetchingService.beerTypes = DataGenerator.finishFetchTypeInfo(.incorrect)
        let userError = UserAlertError.interestsConflict
        viewModel.initFetch()
        mockingFetchingService.fetchTypesSuccess()

        XCTAssertEqual(viewModel.alertMessage, userError.rawValue)
    }    
}


