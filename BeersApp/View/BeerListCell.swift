//
//  BeerListCell.swift
//  BeersApp
//
//  Created by 李祺 on 05/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import UIKit

class BeerListCell: UITableViewCell {
    var berrCellViewModel: BeerListCellViewModel? {
        didSet {
            self.textLabel?.text = berrCellViewModel?.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
