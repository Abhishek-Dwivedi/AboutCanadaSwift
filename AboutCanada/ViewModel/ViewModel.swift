//
//  ViewModel.swift
//  AboutCanada
//
//  Created by abhishek.e.dwivedi on 22/02/1442 AH.
//  Copyright © 1442 abhishek.e.dwivedi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    lazy var networkManager = NetworkManager()
    var dataModel = PublishSubject<CanadaDataModel?>()
    var error = PublishSubject<String?>()
    
    func getCanadaData() {
        networkManager.getCanadaData { (data, error) in
            if let error = error {
                self.error.onNext(error)
            } else {
                self.dataModel.onNext(data)
            }
        }
    }
}
