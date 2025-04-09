//
//  RecipeDetailViewController.swift
//  Recournal
//
//  Created by YarenEteration on 9.04.2025.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: UserRecipeModel?
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let instructionsTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureUI()
    }
    
    func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(instructionsTextView)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            instructionsTextView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 20),
            instructionsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructionsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            instructionsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            instructionsTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureUI() {
        guard let recipe = recipe else { return }
        titleLabel.text = recipe.title
        ingredientsLabel.text = "Ingredients: \(recipe.ingredients)"
        instructionsTextView.text = recipe.instructions
        recipeImageView.image = recipe.image ?? UIImage(systemName: "photo")
    }
}
