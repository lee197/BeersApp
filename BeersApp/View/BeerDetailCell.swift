//
//  BeerDetailCell.swift
//  BeersApp
//
//  Created by 李祺 on 06/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import UIKit

class BeerDetailCell: UITableViewCell {
    var berrDetailCellVM: IngredientModel? {
        didSet {
            self.titleLabel.text = berrDetailCellVM?.ingredientTitle
            self.detailLabel.text = berrDetailCellVM?.detail
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)

        setTitleLabelConstraints()
        setDetailLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.numberOfLines = 0

        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }

    private func setDetailLabelConstraints() {

        let detailLabelConstraints = [
            detailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            detailLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),

            detailLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(detailLabelConstraints)
    }
}
