//
//  MealDetailViewController.swift
//  Recournal
//
//  Created by YarenEteration on 8.04.2025.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    var meal: Meal?
    
    // scrollView ve container ile dikeyde kaydırılabilir halde
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = true
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //stackView içine resim, başlık, malzemeler
    //AutoLAyout yerine dikey sıralamayı yönetmek için
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // UI elemanları
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    private let instructionsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = false  // TextView'ı kendi içinde kaydırmaya gerek yok çünkü tüm sayfa scroll ile kaydırılabilir halde
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupStackView()
        configureUI()
        
        
        //Favorilere eklemek için kalp butonu
        //eğer favorilerdeyse heart.fill
        if let meal = meal, CoreDataManager.shared.isMEalFavorited(meal: meal){
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(addToFavorites))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addToFavorites))
        }
    }
    
    
    private func setupScrollView() {
        // ScrollView --> Ana view
        // contentView --> ScrollView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // ScrollView constraint’leri
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
    
   private func configureUI() {
        guard let meal = meal else {
            print("Hata: Meal değeri nil!")
            return
        }
        titleLabel.text = meal.title
        instructionsTextView.text = meal.instructions
        let ingredientsText = meal.ingredients.joined(separator: "\n")
        ingredientsLabel.text = "Ingredients:\n\(ingredientsText)"
        
        if let imageUrl = URL(string: meal.image) {
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                if let error = error {
                    print("Resim yükleme hatası: \(error.localizedDescription)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.mealImageView.image = image
                    }
                } else {
                    print("Resim verisi bulunamadı veya UIImage'e çevrilemedi.")
                }
            }.resume()
        } else {
            print("Geçersiz resim URL'si: \(meal.image)")
        }
    }

    
    @objc func addToFavorites(){
        guard let meal = meal else {
            print("Meal verisi boş")
            return
        }
        
        CoreDataManager.shared.addToFavorites(meal: meal)
        let alert = UIAlertController(title: "Added!", message: "Meal was added successfully to Favorites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default))
        present(alert, animated: true)
    }
}

