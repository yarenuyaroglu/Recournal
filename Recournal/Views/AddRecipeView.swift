//
//  AddRecipeView.swift
//  Recournal
//
//  Created by YarenEteration on 16.04.2025.
//

import UIKit

class AddRecipeView: UIView {
    
    let scrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    let contentView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // Kullanıcıya gösterilecek resim; başlangıçta placeholder simge
    let recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true  // Dokunmaya izin ver
        return iv
    }()
    // Tarif başlığı için
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Recipe Title"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Malzemeler için text view, placeholder metin ile birlikte ve rengi gray
    let ingredientsTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 5.0
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.text = "Enter ingredients here, e.g. 2 eggs, 1 cup flour, etc."
        tv.textColor = UIColor.gray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // Talimatlar için text view, placeholder metin ile birlikte ve rengi gray
    let instructionsTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 5.0
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.text = "Enter cooking instructions here, e.g. Preheat oven, mix ingredients, etc."
        tv.textColor = UIColor.gray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // Tarifin kaydedilmesini sağlayan buton
    let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Save Recipe", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //Başlatıcılar ve layout ayarları
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setupView()
        setupConstraints()
        
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        [recipeImageView, titleTextField, ingredientsTextView, instructionsTextView, saveButton].forEach {contentView.addSubview($0) }
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // scrollView constraints
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // contentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // UI elemanlarının layout’lanması
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleTextField.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            ingredientsTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            ingredientsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ingredientsTextView.heightAnchor.constraint(equalToConstant: 100),
            
            instructionsTextView.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 20),
            instructionsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructionsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            instructionsTextView.heightAnchor.constraint(equalToConstant: 150),
            
            saveButton.topAnchor.constraint(equalTo: instructionsTextView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
