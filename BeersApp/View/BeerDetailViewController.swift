//
//  BeerDetailViewController.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    let beerDetailViewModel: BeerDetailViewModel
    
    private weak var tableView: UITableView!
    override func loadView() {
        super.loadView()
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        self.tableView = tableView
    }
    
    init(beerDetailViewModel: BeerDetailViewModel) {
        self.beerDetailViewModel = beerDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setTeamDetailView()
//        self.navigationItem.title = teamDetailViewModel.getNavTitle()
    }
    
    func setTeamDetailView() {
        tableView.dataSource = self
        tableView.register(BeerIntroCell.self, forCellReuseIdentifier: "introCell")
        tableView.register(BeerDetailCell.self, forCellReuseIdentifier: "detailCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

extension BeerDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return beerDetailViewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerDetailViewModel.getNumberOfCellsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return beerDetailViewModel.getTitleOfSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "introCell", for: indexPath) as! BeerIntroCell
            cell.beerIntroCellVM = beerDetailViewModel.getBeerIntroCellViewModel()
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! BeerDetailCell
            cell.berrDetailCellVM = beerDetailViewModel.getBeerDetailCellViewModel(at:indexPath)
            return cell
        }
    }
}
