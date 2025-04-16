//
//  MyRecipesViewController.swift
//  Recournal
//
//  Created by YarenEteration on 8.04.2025.
//
import UIKit

class MyRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddRecipeDelegate {
    
    // Kullanıcı tarafından eklenen tariflerin tutulacağı liste
    var recipes: [UserRecipeModel] = []
    
    private var myRecipesView: MyRecipesView! {
        return self.view as? MyRecipesView
    }
    
    override func loadView() {
        view = MyRecipesView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My Recipes"

        // Navigation bar’daki "+" butonu
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addRecipeTapped))
        
        setupTableView()
    }
    
    @objc func addRecipeTapped() {
        // "+" butonuna tıklanınca ekleme ekranına git
        let addVC = AddRecipeViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    
    private func setupTableView() {
        guard let tableView = myRecipesView?.tableView else {return}
        tableView.delegate = self
        tableView.dataSource = self
    }

    
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
    

    func didAddRecipe(_ recipe: UserRecipeModel) {
        recipes.append(recipe)
        myRecipesView?.tableView.reloadData()
    }
}
