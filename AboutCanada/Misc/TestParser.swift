//
//  JSONReader.swift
//  AboutCanada
//
//  Created by abhishek.e.dwivedi on 22/02/1442 AH.
//  Copyright © 1442 abhishek.e.dwivedi. All rights reserved.
//

import Foundation

struct TestParser {
    static func getModelFromJSON(fileName: String) -> CanadaDataModel? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                let response = try JSONDecoder().decode(CanadaDataModel.self, from: utf8Data!)
                return response
            } catch { }
        }
        return CanadaDataModel()
    }
}
