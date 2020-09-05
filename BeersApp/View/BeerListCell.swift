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
            self.titleLabel.text = berrCellViewModel?.name
            self.detailLabel.text = berrCellViewModel?.type
            self.abvLabel.text = "abv: \(berrCellViewModel?.abv ?? "null")"

            self.beerImageView.downloaded(from: berrCellViewModel?.imageUrl ?? "", contentMode: .scaleAspectFit)
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
        self.addSubview(detailLabel)
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
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: self.beerImageView.rightAnchor,constant: 20),
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    private func setDetailLabelConstraints() {

        let detailLabelConstraints = [
            detailLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            detailLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            detailLabel.leftAnchor.constraint(equalTo: self.beerImageView.rightAnchor,constant: 20),

            detailLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(detailLabelConstraints)
    }
    
    private func setBeerAbvLabelConstraints() {

        let detailLabelConstraints = [
            abvLabel.topAnchor.constraint(equalTo: self.detailLabel.bottomAnchor, constant: 20),
            abvLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            abvLabel.leftAnchor.constraint(equalTo: self.beerImageView.rightAnchor,constant: 20),

            abvLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(detailLabelConstraints)
    }
    
    private func setBeerImageConstraints() {
        let beerImageViewConstraints = [
            beerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            beerImageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            beerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),

            beerImageView.heightAnchor.constraint(equalToConstant: 200),
            beerImageView.widthAnchor.constraint(equalToConstant: 100)

        ]
        NSLayoutConstraint.activate(beerImageViewConstraints)
    }
}
