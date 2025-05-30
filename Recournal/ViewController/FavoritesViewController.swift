//
//  FavoritesViewController.swift
//  Recournal
//
//  Created by YarenEteration on 8.04.2025.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //COre Data'dan çekilen favori öğeleri tutuacak olan dizi
    
    var favorites: [NSManagedObject] = []
    
    
    private var favoritesView : FavoritesView!{
        return self.view as? FavoritesView
    }
    
    
    override func loadView() {
        view = FavoritesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorites"
        
        setupTableView()
        fetchFavorites()
    }
    
    
    //ekran her göründüğünde en güncel favori verilerini çekmek için
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
        favoritesView.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.value(forKey: "title") as? String ?? "No Title"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        // NSManagedObject'ten Meal modeline dönüştürmek için initializer kullanıyoruz.
        let meal = Meal(managedObject: favorite)
        let detailVC = MealDetailViewController()
        detailVC.meal = meal
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
    private func setupTableView(){
        guard let tableView = favoritesView?.tableView else {return}
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchFavorites() {
        //Meals entity'sini çekmek için
        let request = NSFetchRequest<NSManagedObject>(entityName: "Meals")
        
        do{
            //Tüm favori kayıtları çekiliyor
            let fetchedFavorites = try CoreDataManager.shared.context.fetch(request)
            
            //Aynı id'ye sahi kayıtları filtrelemek için --> Set
            var seenIDs = Set<String>()
            favorites = fetchedFavorites.filter { favorite in
                if let id = favorite.value(forKey: "id") as? String{
                    if seenIDs.contains(id) {
                        //Bu id daha önce eklenmişse filtrele
                        return false
                    }
                    else {
                        seenIDs.insert(id)
                        return true
                    }
                }
                return false
            }
        } catch {
            print("Favoriler çekilemedi. \(error)")
        }
    }
}
