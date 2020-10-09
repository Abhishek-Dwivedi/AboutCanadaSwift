//
//  AboutCanadaTests.swift
//  AboutCanadaTests
//
//  Created by abhishek.e.dwivedi on 22/02/1442 AH.
//  Copyright © 1442 abhishek.e.dwivedi. All rights reserved.
//

import XCTest
import RxSwift
@testable import AboutCanada

class AboutCanadaTests: XCTestCase {
    
    var viewModel: ViewModel?
    var disposeBag: DisposeBag?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModel()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        disposeBag = nil
    }
    
    func test_get_data() {
        
        viewModel?.getCanadaData()
        viewModel?.dataModel.subscribe(onNext: { (data) in
            //If parsing is successful and data is not nil, testcase is passed.
            //Instead of actual API call, local JSON can be read.
            XCTAssertNotNil(data)
        }).disposed(by: disposeBag!)
    }
}
