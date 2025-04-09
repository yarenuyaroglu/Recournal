//
//  MyRecipesViewController.swift
//  Recournal
//
//  Created by YarenEteration on 8.04.2025.
//
import UIKit

class MyRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddRecipeDelegate {
    
    var tableView: UITableView!
    // Kullanıcı tarafından eklenen tariflerin tutulacağı liste
    var recipes: [UserRecipeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My Recipes"
        
        // TableView kurulumu
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecipeCell")
        view.addSubview(tableView)
        
        // Navigation bar’daki "+" butonu
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addRecipeTapped))
    }
    
    @objc func addRecipeTapped() {
        // "+" butonuna tıklanınca ekleme ekranına git
        let addVC = AddRecipeViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    // MARK: - UITableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].title
        return cell
    }
    
    // Tarife tıklayınca detay ekranına yönlendir
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let detailVC = RecipeDetailViewController()
        detailVC.recipe = recipe
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - AddRecipeDelegate
    func didAddRecipe(_ recipe: UserRecipeModel) {
        recipes.append(recipe)
        tableView.reloadData()
    }
}
