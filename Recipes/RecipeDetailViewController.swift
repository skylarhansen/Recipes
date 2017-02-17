//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Skylar Hansen on 2/17/17.
//  Copyright © 2017 Skylar Hansen. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var recipe: Recipe? {
        didSet {
            if let recipe = recipe,
                let imageURL = recipe.imageURL {
                ImageController.image(forURL: imageURL, completion: { (image) in
                    self.recipeImageView.image = image
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func viewRecipeButtonTapped(_ sender: Any) {
        guard let recipeURLString = recipe?.recipeURL,
            let recipeURL = URL(string: recipeURLString) else { return }
        
        UIApplication.shared.open(recipeURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func saveRecipeButtonTapped(_ sender: Any) {
        
        guard let recipe = recipe else { return }
        recipe.isSaved = true
        RecipeController.shared.addRecipeToMyRecipes(recipe: recipe)
    }
}
