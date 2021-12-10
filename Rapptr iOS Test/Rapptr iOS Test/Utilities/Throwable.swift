//
//  Throwable.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation

public struct Throwable<T: Decodable>: Decodable {
    public let result: Result<T, Error>
    
    public init(from decoder: Decoder) throws {
        let catching = { try T(from: decoder) }
        result = Result(catching: catching)
    }
}
