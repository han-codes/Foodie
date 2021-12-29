//
//  Meal.swift
//  Foodie
//
//  Created by Hannie Kim on 12/23/21.
//

import Foundation

struct MealResponse: Decodable {
    let meals: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawMeals = try container.decode([Meal].self, forKey: .meals)
        meals = rawMeals.sorted { $0.name < $1.name }
    }
}

struct Meal: Decodable {
    let id: String
    let name: String
    let thumbnailURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case thumbnail = "strMealThumb"
        case name = "strMeal"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let thumbnailStr = try container.decode(String.self, forKey: .thumbnail)
        if let thumbnailURL = URL(string: thumbnailStr) {
            self.thumbnailURL = thumbnailURL
        }
        else {
            throw CommonError.invalidURL
        }
    }
}
