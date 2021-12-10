//
//  NetworkService.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation

//------------------------------------------------
// MARK: NetworkService
//------------------------------------------------

class NetworkService {
    static let shared = NetworkService()
    private let urlSession = URLSession.shared
    
    func requestData(url: URL?, completion: @escaping ((Data?)->Void)) {
        guard let _url = url else { return }
        
        urlSession.dataTask(with: _url) { data, resp, err in
            completion(data)
        }.resume()
    }
}
