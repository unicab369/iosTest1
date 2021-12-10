//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct Message {
    var userID: Int
    var username: String
    var avatarURL: URL?
    var text: String
    
    init(testName: String, withTestMessage message: String) {
        self.userID = 0
        self.username = testName
        self.avatarURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png")
        self.text = message
    }
}


struct MessageList: Decodable {
    private(set) var data: [MessageItem] = []
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let throwables = try values.decode([Throwable<MessageItem>].self, forKey: .data)

        throwables.forEach {
            switch $0.result {
            case .success(let category):
                self.data.append(category)
            case .failure(let error):
                print("[CategoryList] err: \(error.localizedDescription)")
            }
        }
    }
}

struct MessageItem: Decodable {
    let user_id: String
    let name: String
    let avatar_url: String
    let message: String
}
