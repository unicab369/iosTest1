//
//  DataService.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    private let domain: String = "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php";
    
    /// network service request for list of CategoryItem
    func getMessages(completion: @escaping (([MessageItem]?)->Void)) {
        guard let url = URL(string: domain) else { return }
        print("\n[\(String(describing: self))] \(#function) \(url.absoluteString)")
        
        NetworkService.shared.requestData(url: url) { data in
            guard let _data = data else {
                completion(nil)
                return
            }

            do {
                let obj = try JSONDecoder().decode(MessageList.self, from: _data)
                completion(obj.data)
                
            } catch let err {
                print("Err", err)
                completion(nil)
            }
        }
    }
}
