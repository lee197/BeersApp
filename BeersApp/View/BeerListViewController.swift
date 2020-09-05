//
//  ViewController.swift
//  BeersApp
//
//  Created by 李祺 on 03/09/2020.
//  Copyright © 2020 Drop. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
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
    
    private lazy var beerListVM = {
        return BeerListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupTableView()
    }
    
    private func initViewModel() {
        beerListVM.showAlertClosure = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.showAlert(alertMessage: self.beerListVM.alertMessage ?? "UNKOWN ERROR")
            }
        }
        
        beerListVM.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                print("ssssss")
                
                self.tableView.reloadData()
            }
        }
        
        beerListVM.initFetch()
    }
    
    private func showAlert(alertMessage:String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "beerCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

extension BeerListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerListVM.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerListCell
        cell.berrCellViewModel = beerListVM.getCellViewModel(at: indexPath)
        return cell
    }
}

extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedBeer = beerListVM.userPressedCell(at: indexPath)
        let vc = BeerDetailViewController(beerDetailViewModel: BeerDetailViewModel(beerDetailModel: selectedBeer))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

