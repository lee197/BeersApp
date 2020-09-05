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
        let incorrectStr = "1\n1 B\n1 C"
        let beerTypeProcessor = BeerTypeProcessor(inputStr: incorrectStr)
        
        let result = beerTypeProcessor.generateBeerTypes()
        
       XCTAssertEqual(result, "No solution exists")
    }
    
    func testIncompleteTpyes() {
        let incorrectStr = "2\n1 B\n1 B"
        let beerTypeProcessor = BeerTypeProcessor(inputStr: incorrectStr)
        
        let result = beerTypeProcessor.generateBeerTypes()
        
       XCTAssertEqual(result, "B C")
    }
    
    func testRightSolution() {
        let correctStr = "5\n2 B\n5 C\n1 C\n5 C 1 C 4 B\n3 C\n5 C\n3 C 5 C 1 C\n3 C\n2 B\n5 C 1 C\n2 B\n5 C\n4 B\n5 C 4 B\n"
        let beerTypeProcessor = BeerTypeProcessor(inputStr: correctStr)
        
        let result = beerTypeProcessor.generateBeerTypes()
        
        XCTAssertEqual(result, "C B C B C")
    }
}
