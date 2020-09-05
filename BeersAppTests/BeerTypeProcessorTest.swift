//
//  BeerTypeProcessorTest.swift
//  BeersAppTests
//
//  Created by 李祺 on 05/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import XCTest
@testable import BeersApp

class BeerTypeProcessorTest: XCTestCase {
    
    func testNoSolution() {
        let incorrectStr = DataGenerator.finishFetchTypeInfo(.incorrect)
        let beerTypeProcessor = BeerTypeProcessor(inputStr: incorrectStr)
        
        let result = beerTypeProcessor.generateBeerTypes()
        
       XCTAssertEqual(result, "No solution exists")
    }
    
    func testIncompleteTpyes() {
        let incorrectStr = DataGenerator.finishFetchTypeInfo(.incomplete)
        let beerTypeProcessor = BeerTypeProcessor(inputStr: incorrectStr)
        
        let result = beerTypeProcessor.generateBeerTypes()
        
       XCTAssertEqual(result, "B C")
    }
    
    func testRightSolution() {
        let correctStr = DataGenerator.finishFetchTypeInfo(.correct)
        let beerTypeProcessor = BeerTypeProcessor(inputStr: correctStr)
        
        let result = beerTypeProcessor.generateBeerTypes()
        
        XCTAssertEqual(result, "C B C B C")
    }
}
