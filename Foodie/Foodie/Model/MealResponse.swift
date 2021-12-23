//
//  MealResponse.swift
//  Foodie
//
//  Created by Hannie Kim on 12/23/21.
//

import Foundation

struct MealResponse: Decodable {
    let mealDetails: [MealDetails]
    
    enum CodingKeys: String, CodingKey {
        case mealDetails = "meals"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mealDetails = try container.decode([MealDetails].self, forKey: .mealDetails)
    }
}
