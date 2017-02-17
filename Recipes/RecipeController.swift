//
//  RecipeController.swift
//  Recipes
//
//  Created by Skylar Hansen on 2/17/17.
//  Copyright © 2017 Skylar Hansen. All rights reserved.
//

import Foundation

class RecipeController {
    
    static let baseURL = URL(string: "http://food2fork.com/api/search")
    static let apiKey = "b37fa4177b1e242db8e30dcac04fca76"
    
    static func getRecipes(forSearchTerm searchTerm: String, completion: @escaping ([Recipe]) -> Void) {
        
        guard let url = baseURL else { return }
        
        let urlParameters = ["key": apiKey, "q": searchTerm]
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: urlParameters, body: nil) { (data, error) in
            
            if let error = error {
                print("Error performing request for URL: \(url) \(error.localizedDescription)")
                completion([])
            }
            
            guard let data = data,
                let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any],
                let recipeDictionaries = jsonDictionary["recipes"] as? [[String:Any]] else {
                    print("Error parsing json.")
                    completion([])
                    return
            }
            
            let recipes = recipeDictionaries.flatMap { Recipe(dictionary: $0) }
            completion(recipes)
        }
    }
}
