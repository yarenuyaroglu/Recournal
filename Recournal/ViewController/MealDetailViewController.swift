//
//  MealDetailViewController.swift
//  Recournal
//
//  Created by YarenEteration on 8.04.2025.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    var meal: Meal?
    var recipe: UserRecipeModel?
    
    
    
    private var mealDetailView: MealDetailView! {
        return self.view as? MealDetailView
    }
    
    override func loadView() {
        view = MealDetailView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        
        
        //Favorilere eklemek için kalp butonu
        //eğer favorilerdeyse heart.fill
        if let meal = meal, CoreDataManager.shared.isMEalFavorited(meal: meal){
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(addToFavorites))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addToFavorites))
        }
    }
    

    //bir fonksiyonda çok iş yapılmış. 
   private func configureUI() {
        guard let meal = meal else {
            print("Hata: Meal değeri nil!")
            return
        }
       mealDetailView.titleLabel.text = meal.title
       mealDetailView.instructionsTextView.text = meal.instructions
        let ingredientsText = meal.ingredients.joined(separator: "\n")
       mealDetailView.ingredientsLabel.text = "Ingredients:\n\(ingredientsText)"
        
        if let imageUrl = URL(string: meal.image) {
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                if let error = error {
                    print("Resim yükleme hatası: \(error.localizedDescription)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.mealDetailView.mealImageView.image = image
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

