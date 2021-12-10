//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/
struct LoginItem: Decodable {
    let code: String
    let message: String
}

class LoginClient {
    
    private var session: URLSession?
    
    static func login(email: String, password: String, completion: @escaping (String) -> Void, error errorHandler: @escaping (String?) -> Void) {
        var request = URLRequest(url: URL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php")!)
        request.httpMethod = "POST"

        let postString = NSString(format: "email=%@&password=%@", email, password)
        request.httpBody = postString.data(using: String.Encoding.utf8.rawValue)
        
        URLSession.shared.dataTask(with: request) { data, resp, err in
            guard let data = data else {
                errorHandler("Error: No Data")
                return
            }
            let jsonData = try? JSONDecoder().decode(LoginItem.self, from: data)
            if jsonData?.code.uppercased() != "SUCCESS" {
                errorHandler(jsonData?.message)
            } else {
                completion(jsonData?.message ?? "")
            }
        }.resume()
        
        
    }
}
