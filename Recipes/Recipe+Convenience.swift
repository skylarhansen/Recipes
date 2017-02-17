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
