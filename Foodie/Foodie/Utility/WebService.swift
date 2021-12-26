//
//  Webservice.swift
//  Foodie
//
//  Created by Hannie Kim on 12/22/21.
//

import Foundation

class WebService {
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    static func fetchRandomMealDetails(completion: @escaping (MealDetails?, Error?) -> Void) {
        guard let randomMealURL = URL(string: Constants.API.URLString.randomMealURL) else {
            print("Unable to unwrap a valid URL for fetching a random meal")
            return
        }
        
        var request = URLRequest(url: randomMealURL)
        request.httpMethod = WebService.HTTPMethod.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            try? prettyPrintJSON(data: data)
            
            do {
                let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
                
                if let mealDetails = mealResponse.mealDetails.first {
                    completion(mealDetails, nil)
                }
                else {
                    completion(nil, CommonError.missingData)
                }
            }
            catch {
                print("Failed to decode meal response with error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
    }
    
    static func fetchMealCategories(completion: @escaping ([MealCategory]?, Error?) -> Void) {
        guard let categoriesURL = URL(string: Constants.API.URLString.mealCategoriesURL) else {
            print("Unable to unwrap a valid URL for fetching meal categories")
            return
        }
        
        var request = URLRequest(url: categoriesURL)
        request.httpMethod = WebService.HTTPMethod.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            try? prettyPrintJSON(data: data)
            
            do {
                let mealCategoryResponse = try JSONDecoder().decode(MealCategoryResponse.self, from: data)
                completion(mealCategoryResponse.categories, nil)
            }
            catch {
                print("Failed to decode meal category response with error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
    }
    
    static func fetchMealsByCategory(_ category: String) {
        
        guard let mealsByCategoryURL = Constants.API.URLs.lookupMealsByCategoryURL(category) else {
            print("Unable to unwrap a valid URL for fetching meals by a category")
            return
        }
        
        var request = URLRequest(url: mealsByCategoryURL)
        request.httpMethod = WebService.HTTPMethod.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            try? prettyPrintJSON(data: data)
        }.resume()
    }
    
    static func fetchMealDetails(usingId id: String) {
        guard let mealDetailsURL = Constants.API.URLs.lookupMealURL(usingID: id) else {
            print("Unable to unwrap a valid URL for fetching meal details")
            return
        }
        
        var request = URLRequest(url: mealDetailsURL)
        request.httpMethod = WebService.HTTPMethod.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            try? prettyPrintJSON(data: data)
        }.resume()
    }
    
    private static func prettyPrintJSON(data: Data, options: JSONSerialization.ReadingOptions = []) throws {
        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: options) as? NSDictionary {
            print(jsonResult)
        }
    }
}
