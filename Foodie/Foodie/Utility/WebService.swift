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
    
    static func fetchRandomMealDetails(completion: @escaping (Result<MealDetails, Error>) -> Void) {
        guard let randomMealURL = URL(string: Constants.API.URLString.randomMealURL) else {
            print("Unable to unwrap a valid URL for fetching a random meal")
            return
        }
        
        var request = URLRequest(url: randomMealURL)
        request.httpMethod = WebService.HTTPMethod.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(CommonError.missingData))
                return
            }
            
            try? prettyPrintJSON(data: data)
            
            do {
                let mealResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                
                if let mealDetails = mealResponse.mealDetails.first {
                    completion(.success(mealDetails))
                }
                else {
                    completion(.failure(CommonError.missingData))
                }
            }
            catch {
                print("Failed to decode meal response with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func fetchMealCategories(completion: @escaping (Result<[MealCategory], Error>) -> Void) {
        guard let categoriesURL = URL(string: Constants.API.URLString.mealCategoriesURL) else {
            print("Unable to unwrap a valid URL for fetching meal categories")
            completion(.failure(CommonError.invalidURL))
            return
        }
        
        var request = URLRequest(url: categoriesURL)
        request.httpMethod = WebService.HTTPMethod.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(CommonError.missingData))
                return
            }
            
            try? prettyPrintJSON(data: data)
            
            do {
                let mealCategoryResponse = try JSONDecoder().decode(MealCategoryResponse.self, from: data)
                completion(.success(mealCategoryResponse.categories))
            }
            catch {
                print("Failed to decode meal category response with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func fetchMealsByCategory(_ category: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
        guard let mealsByCategoryURL = Constants.API.URLs.lookupMealsByCategoryURL(category) else {
            print("Unable to unwrap a valid URL for fetching meals by a category")
            completion(.failure(CommonError.invalidURL))
            return
        }
        
        var request = URLRequest(url: mealsByCategoryURL)
        request.httpMethod = WebService.HTTPMethod.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(CommonError.missingData))
                return
            }
            
            try? prettyPrintJSON(data: data)
            
            do {
                let mealCategoryResponse = try JSONDecoder().decode(MealResponse.self, from: data)
                completion(.success(mealCategoryResponse.meals))
            }
            catch {
                print("Failed to decode meal response with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func fetchMealDetails(usingId id: String, completion: @escaping (Result<MealDetails, Error>) -> Void) {
        guard let mealDetailsURL = Constants.API.URLs.lookupMealURL(usingID: id) else {
            print("Unable to unwrap a valid URL for fetching meal details")
            completion(.failure(CommonError.invalidURL))
            return
        }
        
        var request = URLRequest(url: mealDetailsURL)
        request.httpMethod = WebService.HTTPMethod.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(CommonError.missingData))
                return
            }
            
            try? prettyPrintJSON(data: data)
            
            do {
                let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                
                if let mealDetails = mealDetailResponse.mealDetails.first {
                    completion(.success(mealDetails))
                }
                else {
                    completion(.failure(CommonError.missingData))
                }
            }
            catch {
                print("Failed to decode meal detail response with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    private static func prettyPrintJSON(data: Data, options: JSONSerialization.ReadingOptions = []) throws {
        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: options) as? NSDictionary {
            print(jsonResult)
        }
    }
}
