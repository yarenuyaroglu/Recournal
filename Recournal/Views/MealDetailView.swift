//
//  MealDetailView.swift
//  Recournal
//
//  Created by YarenEteration on 16.04.2025.
//

import UIKit

class MealDetailView: UIView {

    
    // scrollView ve container ile dikeyde kaydırılabilir halde
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = true
        return sv
    }()
 
    private let contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // UI elemanları
     let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
     let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
     let instructionsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = false  // TextView'ı kendi içinde kaydırmaya gerek yok çünkü tüm sayfa scroll ile kaydırılabilir halde
        return textView
    }()
    
    //Başlatıcılar ve layout ayarları
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
        setupScrollView()
        setupStackView()
    }
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setupView()
        setupScrollView()
        setupStackView()
    }
        
    private func setupView() {
        backgroundColor = .white
        }

    private func setupScrollView() {
        // ScrollView --> Ana view
        // contentView --> ScrollView
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // ScrollView constraint’leri
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // contentView’i scrollView’e 4 kenardan sabitle
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // içerik genişliği, scrollView genişliğine eşit olsun ki yatayda kaymasın
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupStackView() {
        // contentView içine stackView ekle
        contentView.addSubview(stackView)
        
        // stackView constraint’leri
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        // stackView içine elemanları ekleme sırasına göre doldur:
        stackView.addArrangedSubview(mealImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(ingredientsLabel)
        stackView.addArrangedSubview(instructionsTextView)
        
        // Sabit yükseklik
        mealImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    }
