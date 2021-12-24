//
//  JSONSerialization+Convenience.swift
//  Foodie
//
//  Created by Hannie Kim on 12/24/21.
//

import Foundation

extension JSONSerialization {
    func prettyPrintJSON(data: Data, options: ReadingOptions = []) throws {
        if let json = try JSONSerialization.jsonObject(with: data, options: options) as? NSDictionary {
            print(json)
        }
    }
}
