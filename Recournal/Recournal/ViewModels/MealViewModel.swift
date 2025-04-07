//
//  MealViewModel.swift
//  Recournal
//
//  Created by YarenEteration on 7.04.2025.
//

import Foundation
import Combine

//MealViewModel, ObserverObject protokülünü uygular.
//Bu, Combine ile UI güncellemelerini yönetmeyi sağlar

class MealViewModel : ObservableObject{
    //UI tarafından gözlemlenecek veriler:
    //1. meals : API'den gelen tariflerin listesi
    //2. errorMEssage : Hata mesajı, eğer bir hata oluşursa
    
    
    //@Published ile bu değişkenlerde bir değişiklik olduğunda onları subscribe eden nesnelere otomatik bildirim gönderilir.
    @Published var meals : [Meal] = []
    @Published var errorMessage : String = ""
    
    
    //Combine aboneliklerini saklamak için bir set
    private var cancellables = Set<AnyCancellable>()
    
    
    //API'den tarifleri çekmek için fonksiyon
    func fetchMeals() {
        
        //NetworkManager'ın fetchMeals fonksiyonunu çağırır.
        NetworkManager.shared.fetchMeals()
            .sink { [weak self] completion in
                // Hata kontrolü : Eğer hata oluşursa errorMessage
                switch completion{
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] meals in
                    //Başarılı veri çekilirse meals dizisi güncellensin
                    self?.meals = meals
                }
                .store(in: &cancellables) //Aboneliği sakla
        }
}
