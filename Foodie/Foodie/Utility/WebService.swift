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
    
    static func fetchRandomMeal(completion: @escaping (MealResponse?, Error?) -> Void) {
        
        guard let randomMealURL = URL(string: Constants.API.URL.randomMealURL) else {
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
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(jsonResult)
                }
                let randomMeal = try JSONDecoder().decode(MealResponse.self, from: data)
                completion(randomMeal, nil)
            }
            catch {
                print("Failed to decode meal response with error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
    }
}
