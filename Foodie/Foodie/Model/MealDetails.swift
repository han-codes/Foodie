//
//  MealDetails.swift
//  Foodie
//
//  Created by Hannie Kim on 12/23/21.
//

import Foundation

struct MealDetailResponse: Decodable {
    let mealDetails: [MealDetails]
    
    enum CodingKeys: String, CodingKey {
        case mealDetails = "meals"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mealDetails = try container.decode([MealDetails].self, forKey: .mealDetails)
    }
}

struct MealDetails: Decodable {
    let id: String
    let name: String
    let category: String
    let instructions: String
    let ingredients: [String]
    let thumbnailURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
    }
    
    struct IngredientKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            self.stringValue = "\(intValue)";
            self.intValue = intValue
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(String.self, forKey: .category)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        let thumbnailStr = try container.decode(String.self, forKey: .thumbnail)
        if let thumbnailURL = URL(string: thumbnailStr) {
            self.thumbnailURL = thumbnailURL
        }
        else {
            throw CommonError.invalidURL
        }
        
        let ingredientsContainer = try decoder.container(keyedBy: IngredientKeys.self)
        
        var ingredients = [String]()
        for key in ingredientsContainer.allKeys {
            let string = try ingredientsContainer.decode(String?.self, forKey: key)
            
            if key.stringValue.hasPrefix("strIngredient"), let ingredient = string {
                if !ingredient.isEmpty {
                    ingredients.append(ingredient)
                }
            }
        }
        self.ingredients = ingredients
    }
}
