//
//  MealCategory.swift
//  Foodie
//
//  Created by Hannie Kim on 12/23/21.
//

import Foundation

struct MealCategoryResponse: Decodable {
    let categories: [MealCategory]
    
    enum CodingKeys: String, CodingKey {
        case categories
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawCategories = try container.decode([MealCategory].self, forKey: .categories)
        categories = rawCategories.sorted { $0.title < $1.title }
    }
}

struct MealCategory: Decodable {
    let id: String
    let title: String
    let thumbnailURL: URL
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case title = "strCategory"
        case thumbnail = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        
        let thumbnailStr = try container.decode(String.self, forKey: .thumbnail)
        if let thumbnailURL = URL(string: thumbnailStr) {
            self.thumbnailURL = thumbnailURL
        }
        else {
            throw CommonError.invalidURL
        }
    }
}
