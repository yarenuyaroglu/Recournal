//
//  MyRecipesView.swift
//  Recournal
//
//  Created by YarenEteration on 16.04.2025.
//

import UIKit

class MyRecipesView: UIView {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecipeCell")
        return tableView
    }()
 
    
       override init(frame: CGRect) {
           super.init(frame: frame)
           backgroundColor = .white
           addSubview(tableView)
           setupConstraints()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           backgroundColor = .white
           addSubview(tableView)
           setupConstraints()
       }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
