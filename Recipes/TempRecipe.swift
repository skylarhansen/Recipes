//
//  TempRecipe.swift
//  Recipes
//
//  Created by Skylar Hansen on 2/17/17.
//  Copyright © 2017 Skylar Hansen. All rights reserved.
//

import Foundation

class TempRecipe {
    
    static let kTitle = "title"
    static let kRecipeURL = "source_url"
    static let kImageURL = "image_url"
    
    let title: String
    let recipeURL: String
    let imageURL: String
    
    init?(dictionary: [String:Any]) {
        guard let title = dictionary[TempRecipe.kTitle] as? String,
            let recipeURL = dictionary[TempRecipe.kRecipeURL] as? String,
            let imageURL = dictionary[TempRecipe.kImageURL] as? String else { return nil }
        
        self.title = title
        self.recipeURL = recipeURL
        self.imageURL = imageURL
    }
}
