//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */

class ChatClient {
    private let domain: String = "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php";
    
    func fetchChatData(completion: @escaping ([MessageItem]) -> Void, error errorHandler: @escaping (String?) -> Void) {
        guard let url = URL(string: domain) else { return }
        print("\n[\(String(describing: self))] \(#function) \(url.absoluteString)")
        
        NetworkService.shared.requestData(url: url) { data in
            guard let _data = data else {
                errorHandler("Error: No Data")
                return
            }

            do {
                let obj = try JSONDecoder().decode(MessageList.self, from: _data)
                completion(obj.data)
                
            } catch let err {
                errorHandler("Error: \(err.localizedDescription)")
            }
        }
    }
}
