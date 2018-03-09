//
//  RecipeController.swift
//  Recipes
//
//  Created by Skylar Hansen on 2/17/17.
//  Copyright © 2017 Skylar Hansen. All rights reserved.
//

import Foundation
import CoreData

class RecipeController {
    
    static let shared = RecipeController()
    
    var recipeMasterList: [Recipe] = []
    var myRecipes: [Recipe] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    func getRecipes(forSearchTerm searchTerm: String, completion: @escaping ([Recipe]) -> Void) {
        
        let baseURL = URL(string: "http://food2fork.com/api/search")
        let apiKey = "b37fa4177b1e242db8e30dcac04fca76"
        
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
            self.recipeMasterList = recipes
            completion(recipes)
        }
    }
    
    func addRecipeToMyRecipes(recipe: Recipe) {
        deleteRecipesFromContext(recipes: recipeMasterList)
        myRecipes.append(recipe)
        saveToPersistentStore()
    }
    
    func deleteRecipesFromContext(recipes: [Recipe]) {
        for recipe in recipes {
            if !recipe.isSaved {
                recipe.managedObjectContext?.delete(recipe)
            }
        }
    }
    
    func delete(recipe: Recipe) {
        guard let index = myRecipes.index(of: recipe) else { return }
        myRecipes.remove(at: index)
        recipe.managedObjectContext?.delete(recipe)
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        myRecipes = (try? CoreDataStack.context.fetch(request)) ?? []
    }
}
