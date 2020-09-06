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
    var sut: BeerListViewModel!
    fileprivate var mockingFetchingService: BeerListMockService!
    
    override func setUp() {
        self.mockingFetchingService = BeerListMockService()
        self.sut = BeerListViewModel(apiClient: mockingFetchingService)
    }
    
    override func tearDown() {
        self.mockingFetchingService = nil
        self.sut = nil
    }
    
    func testFetchBeerTypesAndListSuccess() {
        let beerList = fetchFinished()
        let index = IndexPath(row: 0, section: 0)
        
        XCTAssertEqual(sut.getCellViewModel(at: index).name, beerList[0].name)
    }
    
    func testFetchBeerTypesFailed() {
        let userError = UserAlertError.serverError
        let error = APIError.dataDecodingError
        
        sut.initFetch()
        mockingFetchingService.fetchBeerTypeFail(error: error)
        
        XCTAssertEqual(sut.alertMessage, userError.rawValue)
    }
    
    func testFetchBeerListFailed() {
        mockingFetchingService.beerTypes = DataGenerator.finishFetchTypeInfo(.correct)
        
        let userError = UserAlertError.serverError
        let error = APIError.dataDecodingError
        
        sut.initFetch()
        mockingFetchingService.fetchTypesSuccess()
        mockingFetchingService.fetchBeerListFail(error: error)
        
        XCTAssertEqual(sut.alertMessage, userError.rawValue)
    }
    
    func testNoSolution() {
        mockingFetchingService.beerTypes = DataGenerator.finishFetchTypeInfo(.incorrect)
        let userError = UserAlertError.interestsConflict
        sut.initFetch()
        mockingFetchingService.fetchTypesSuccess()
        
        XCTAssertEqual(sut.alertMessage, userError.rawValue)
    }
    
    func testUserPressedCell() {
        let beerList = fetchFinished()
        let index = IndexPath(row: 0, section: 0)
        
        XCTAssertEqual(sut.userPressedCell(at: index).beerIntroModel.name, beerList[index.row].name)
        XCTAssertEqual(sut.userPressedCell(at: index).beerProcessList.count , 3 )
    }
    
    func fetchFinished() -> [BeerListModel] {
        mockingFetchingService.beerTypes = DataGenerator.finishFetchTypeInfo(.correct)
        let beerList = DataGenerator.fetchUsefulBeerInfo()
        mockingFetchingService.beerList = beerList
        sut.initFetch()
        mockingFetchingService.fetchTypesSuccess()
        mockingFetchingService.fetchListSuccess()
        return beerList
    }
}


