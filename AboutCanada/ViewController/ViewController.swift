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

class ViewController: UIViewController {
    
    lazy var vm = ViewModel()
    let db = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vm.getCanadaData()
        bindData()
    }
    
    private func bindData() {
        vm.dataModel
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                //reload table.
            }).disposed(by: db)
        
        vm.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showErrorAlert(error: error)
            }).disposed(by: db)
    }
}

