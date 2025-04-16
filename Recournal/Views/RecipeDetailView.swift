//
//  RecipeDetailView.swift
//  Recournal
//
//  Created by YarenEteration on 16.04.2025.
//

import UIKit

class RecipeDetailView: UIView {

    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    let contentView: UIView = {
        let cv = UIView()
        return cv
    }()
    
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupScrollView()
        setupUIElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        setupScrollView()
        setupUIElements()
    }
    
    private func setupScrollView() {
            addSubview(scrollView)
            scrollView.addSubview(contentView)
            
            NSLayoutConstraint.activate([
                // ScrollView constraint'leri
                scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                // ContentView constraint'leri
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        }
    
    private func setupUIElements() {
           // UI elemanlarını contentView'e ekliyoruz
           [recipeImageView, titleLabel, ingredientsLabel, instructionsTextView].forEach {
               contentView.addSubview($0)
           }
           
           // Constraint’leri tanımlıyoruz
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
    
}
