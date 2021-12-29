//
//  URL+QueryItem.swift
//  Foodie
//
//  Created by Hannie Kim on 12/29/21.
//

import Foundation

extension URL {
    mutating func append(queryItem: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        
        var queryItems = [URLQueryItem]()

        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        
        if let urlWithComponents = urlComponents.url {
            self = urlWithComponents
        }
    }
}
