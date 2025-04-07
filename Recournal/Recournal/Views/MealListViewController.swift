//
//  ViewController.swift
//  Recournal
//
//  Created by YarenEteration on 7.04.2025.
//

import UIKit
import Combine

class MealListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    private let viewModel = MealViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let tableView = UITableView()
    
    
    //tableView'da kaç satır olsun
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    
    
    //tableView hücreleri veriyi nasıl göstersin 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        let meal = viewModel.meals[indexPath.row]
        //hücrede tarifin başlığını göster
        cell.textLabel?.text = meal.title
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()               //UI elemanlarını kur
        bindViewModel()         //ViewModel ile abonelikleri oluştur
        viewModel.fetchMeals()  //API'den tarifleri çekmeye başla
    }


    private func setupUI(){
        view.addSubview(tableView)
        tableView.frame = view.bounds //tableView, tüm ekranı kaplasın
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MealCell")
    }
    
    private func bindViewModel(){
        //MealViewModel'deki meals değişkenini dinle ve TableView'ı güncelle.
        viewModel.$meals
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()}
            .store(in: &cancellables)
        
        //Hata mesajlarını dinle ve gerektiğinde alert ile göster
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self ] error in
                if !error.isEmpty{
                    self?.showAlert(message: error)
                }
            }
            .store(in: &cancellables)
    }
    
    //Hata durumunda alert gösteren foksiyon
    private func showAlert(message : String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default))
        present(alert, animated: true)
        
    }
    
    
}

