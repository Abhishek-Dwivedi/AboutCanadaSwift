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
    
    lazy var viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    var safeArea = UILayoutGuide()
    var data = CanadaDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        setupTableView()
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
    
    private func bindData() {
        viewModel.dataModel
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.data = data ?? CanadaDataModel()
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                if self?.presentingViewController == nil {
                    self?.showErrorAlert(error: error)
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
