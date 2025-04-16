//
//  NetworkingManager.swift
//  Recournal
//
//  Created by YarenEteration on 7.04.2025.
//

import Foundation
import Combine

//Network Manager
class NetworkManager{
    
    //singleton örneği
    static let shared = NetworkManager()

    private init() { }
    
    
    //Apiden rastgele tarifleri çekmek için Combine publisher fonksiyonu
    func fetchMeals() -> AnyPublisher<[Meal], Error> {
        
        
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s="
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            //Url stringi dışarıdan alırsan kullan.
        }
        
        //URLSession ile veri çekip, decode ediyoruz.
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data}
            .decode(type: MealResponse.self, decoder: JSONDecoder())
            .map{ $0.meals}
            .receive(on: DispatchQueue.main) //UI güncellemeleri için main thread
            .eraseToAnyPublisher()
    }
}
    
    
    

