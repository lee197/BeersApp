//
//  BeerTypeProcessor.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import Foundation

struct CustomerInterest: Hashable {
    let beerType: String
    let beerProcessMethod: String
}

class BeerTypeProcessor {
    
    var total: Int
    var inputStr: [String.SubSequence]
    
    init(inputStr: String) {
        self.inputStr = inputStr.split(separator: "\n")
        self.total = Int(self.inputStr.remove(at: 0))!
    }
    
    func generateBeerTypes() -> String {
        let customerInterests = processData()
        let interestSet = Set(customerInterests)
        var result = [String](repeating: "", count: self.total)
        if interestSet.count > total {
            return "No solution exists"
        }
        
        for item in interestSet {
            result[Int(item.beerType)! - 1] = item.beerProcessMethod
        }
        
        if result.contains("") {
            for index in 0 ... result.count - 1 {
                if result[index] == "" {
                    result[index] = "C"
                }
            }
        }
        
        return result.joined(separator:" ")
    }
    
    private func processData() -> [CustomerInterest] {
        
        let interestsList = self.inputStr.map { $0.split(separator: " ") }.map { element -> [CustomerInterest] in
            var index = 0
            var customerInterests = [CustomerInterest]()
            while index < element.count {
                customerInterests.append(CustomerInterest(beerType: String(element[index]), beerProcessMethod: String(element[index+1])))
                index += 2
            }
            return customerInterests
            
        }.flatMap { $0 }
        
        return interestsList
    }
}

