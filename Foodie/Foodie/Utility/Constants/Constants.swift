//
//  Constants.swift
//  Foodie
//
//  Created by Hannie Kim on 12/22/21.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://www.themealdb.com/api/json/v1/1"
        
        struct Path {
            static let random = "/random.php"
            static let lookup = "/lookup.php"
            static let categories = "/categories.php"
            static let filter = "/filter.php"
        }
        
        struct URLString {
            static let randomMealURL = baseURL + Path.random
            static let mealCategoriesURL = baseURL + Path.categories
        }
        
        struct URLs {
            static func lookupMealURL(usingID id: String) -> URL? {
                var url = URL(string: baseURL + Path.lookup)
                url?.append(queryItem: "i", value: id)
                return url
            }
            
            static func lookupMealsByCategoryURL(_ category: String) -> URL? {
                var url = URL(string: baseURL + Path.filter)
                url?.append(queryItem: "c", value: category)
                return url
            }
        }
    }
}
