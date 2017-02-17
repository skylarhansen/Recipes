//
//  Recipe+Convenience.swift
//  Recipes
//
//  Created by Skylar Hansen on 2/17/17.
//  Copyright © 2017 Skylar Hansen. All rights reserved.
//

import Foundation
import CoreData

extension Recipe {
    
    convenience init(title: String, recipeURL: String, imageURL: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.title = title
        self.recipeURL = recipeURL
        self.imageURL = imageURL
    }
}

// MARK: - JSON

extension Recipe {
    
    static let kTitle = "title"
    static let kRecipeURL = "source_url"
    static let kImageURL = "image_url"
    
    convenience init?(dictionary: [String:Any]) {
        guard let title = dictionary[Recipe.kTitle] as? String,
            let recipeURL = dictionary[Recipe.kRecipeURL] as? String,
            let imageURL = dictionary[Recipe.kImageURL] as? String else { return nil }
        
        self.init(title: title, recipeURL: recipeURL, imageURL: imageURL)
    }
}
