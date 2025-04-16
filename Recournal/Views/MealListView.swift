//
//  MealListView.swift
//  Recournal
//
//  Created by YarenEteration on 16.04.2025.
//

import UIKit

class MealListView: UIView {
 
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
         
        //register işlemi
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MealCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
           setupConstraints()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupView()
           setupConstraints()
       }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
