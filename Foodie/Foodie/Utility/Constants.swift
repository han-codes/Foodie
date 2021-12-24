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
            static let lookup = "/lookup.php?i="
            static let categories = "/categories.php"
        }
        
        struct URL {
            static func lookupMealURL(usingID id: Int) -> String {
                return baseURL + Path.lookup + "\(id)"
            }
            
            static let randomMealURL = baseURL + Path.random
            static let mealCategoriesURL = baseURL + Path.categories
        }
    }
}
