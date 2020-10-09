//
//  CanadaDataModel.swift
//  AboutCanada
//
//  Created by abhishek.e.dwivedi on 22/02/1442 AH.
//  Copyright © 1442 abhishek.e.dwivedi. All rights reserved.
//

import Foundation

struct CanadaDataModel: Codable {
    var title: String?
    var rows: [CanadaData]?
}

struct CanadaData: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}
