//
//  MainTabBarController.swift
//  Recournal
//
//  Created by YarenEteration on 8.04.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = MealListViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)

        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        let myRecipesVC = MyRecipesViewController()
        myRecipesVC.tabBarItem = UITabBarItem(title: "My Recipes", image: UIImage(systemName: "pencil.and.scribble"), tag: 2)
        
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        let myRecipesNav = UINavigationController(rootViewController: myRecipesVC)
        
        viewControllers = [homeNav, favoritesNav, myRecipesNav]
        selectedIndex = 0
    }
}
