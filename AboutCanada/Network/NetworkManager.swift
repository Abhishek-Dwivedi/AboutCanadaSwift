//
//  NetworkManager.swift
//  AboutCanada
//
//  Created by abhishek.e.dwivedi on 22/02/1442 AH.
//  Copyright © 1442 abhishek.e.dwivedi. All rights reserved.
//

import Foundation

class NetworkManager {
    private let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    typealias Completion = (CanadaDataModel?, _ error: String?) -> Void
    
    /*
     Fetches data from backend and returns to view model in completion.
     Params - completion with below params
        - data model
        - error.
     */
    func getCanadaData(completion: @escaping Completion) {
        if let url = URL(string: self.url) {
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(HeaderConstants.json.rawValue, forHTTPHeaderField: HeaderConstants.contentType.rawValue)
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, request, error) in
                guard let data = data else { return }
                do {
                    //using utf8 to handle parsing.
                    let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                    let response = try JSONDecoder().decode(CanadaDataModel.self, from: utf8Data!)
                    completion(response, nil)
                } catch {
                    completion(nil, ErrorConstants.generic.rawValue)
                }
            }
            task.resume()
        }
    }
}
