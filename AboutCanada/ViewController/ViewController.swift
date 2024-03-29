//
//  ViewController.swift
//  AboutCanada
//
//  Created by abhishek.e.dwivedi on 22/02/1442 AH.
//  Copyright © 1442 abhishek.e.dwivedi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ViewController: UIViewController {
    
    private var viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    private var safeArea = UILayoutGuide()
    private var data = CanadaDataModel()
    
    /*
     UI Components
     */
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        setupTableView()
        setupRefreshControl()
        viewModel.getCanadaData()
        bindData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }
    
    /*
     Pull to refresh
     */
    private func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Details...", attributes: nil)
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Data
        viewModel.getCanadaData()
        self.refreshControl.endRefreshing()
    }
    
    /*
     Binds view model variables to view controller to observe changes in the properties.
     - On change of data, reload the table.
     - On change of error, show error alert.
     */
    private func bindData() {
        viewModel.dataModel
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.data = data ?? CanadaDataModel()
                self?.title = data?.title
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                if let error = error {
                    if error != "" {
                        if self?.presentingViewController == nil {
                            self?.showErrorAlert(error: error)
                        }
                    }
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: Table View Data Source.
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let data = self.data.rows?[indexPath.row]
        if let data = data {
            cell.titleLabel.text = data.title
            cell.descriptionLabel.text = data.description
            if let url = data.imageHref {
                let url = URL(string: url)
                cell.imageview.kf.setImage(with: url)
            }
        }
        return cell
    }
}
