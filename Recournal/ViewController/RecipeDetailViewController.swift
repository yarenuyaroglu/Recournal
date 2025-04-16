//
//  RecipeDetailViewController.swift
//  Recournal
//
//  Created by YarenEteration on 9.04.2025.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: UserRecipeModel?

    private var recipeDetailView: RecipeDetailView! {
           return self.view as? RecipeDetailView
       }
    
       
    override func loadView() {
        view = RecipeDetailView()
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        guard let recipe = recipe else { return }
        recipeDetailView.titleLabel.text = recipe.title
        recipeDetailView.ingredientsLabel.text = "Ingredients: \(recipe.ingredients)"
        recipeDetailView.instructionsTextView.text = recipe.instructions
        recipeDetailView.recipeImageView.image = recipe.image ?? UIImage(systemName: "photo")
    }
}
