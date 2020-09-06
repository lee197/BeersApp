//
//  BeerIntroCell.swift
//  BeersApp
//
//  Created by 李祺 on 06/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import UIKit

class BeerIntroCell: UITableViewCell {
    var beerIntroCellVM: BeerIntroCellViewModel? {
        didSet {
            self.titleLabel.text = beerIntroCellVM?.name
            self.descriptionLabel.text = beerIntroCellVM?.description
            self.abvLabel.text = "abv: \(beerIntroCellVM?.abv ?? "null")"

            self.beerImageView.downloaded(from: beerIntroCellVM?.imageUrl ?? "", contentMode: .scaleAspectFit)
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private var abvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let beerImageView: ScaleAspectFitImageView = {
        let imageView = ScaleAspectFitImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(beerImageView)
        self.addSubview(abvLabel)

        setTitleLabelConstraints()
        setDetailLabelConstraints()
        setBeerImageConstraints()
        setBeerAbvLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.numberOfLines = 0

        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.beerImageView.bottomAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    private func setBeerAbvLabelConstraints() {

        let detailLabelConstraints = [
            abvLabel.topAnchor.constraint(equalTo: self.beerImageView.bottomAnchor, constant: 20),
            abvLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            abvLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(detailLabelConstraints)
    }
    
    private func setDetailLabelConstraints() {
        descriptionLabel.numberOfLines = 0
        let detailLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10)

        ]
        NSLayoutConstraint.activate(detailLabelConstraints)
    }
    
    private func setBeerImageConstraints() {
        let beerImageViewConstraints = [
            beerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            beerImageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            beerImageView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20),
            beerImageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -20),
            beerImageView.heightAnchor.constraint(equalToConstant: 200),
        ]
        NSLayoutConstraint.activate(beerImageViewConstraints)
    }
}
