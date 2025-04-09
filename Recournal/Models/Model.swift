
//
//  Model.swift
//  Recournal
//
//  Created by YarenEteration on 7.04.2025.
//


import Foundation
import Combine
import CoreData

//Dinamik CodingKey yapısı --> Sabit olmayan keyleri işlemek için.
//ingredient_1, ingredient_2 gibi
struct DynamicCodingKeys : CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    
    var intValue: Int? = nil
    init?(intValue: Int) {
        return nil
    }
}

//Tarif Modeli
struct Meal: Codable, Identifiable {
    let id: String                  //idMeal
    let title: String               //strMeal
    let image: String               //strMealThumb
    let summary: String             //Kısa açıklama
    let instructions: String        //strInstructions
    let ingredients: [String]       //Malzemeler ve ölçü listesi
    
    
    
    //sabit alanlar için CodingKeys
    enum CodingKeys: String, CodingKey{
        case id = "idMeal"
        case title = "strMeal"
        case image = "strMealThumb"
        case instructions = "strInstructions"
    }
    
    
    
    //Custom init ile dinamik ingredient ve measure alanları için
    //Json verisini modele uygun hale getirmek için
    init(from decoder: any Decoder) throws {
        //Sabit alanları decode et
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.image = try container.decode(String.self, forKey: .image)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        
        //mesela ilk 100 karakteri özet olarak belirle
        self.summary = String(self.instructions.prefix(100))
        
        //Dinamik olaak 20 adet ingredient ve measure alanını kontrol etsin.
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempIngredients = [String]()
        
        for index in 1...20{
            
            
            //mesela strIngredient1,strIngredient2,strMeasure1,strMeasure2
            let ingredientKeyString = "strIngredient\(index)"
            let measureKeyString = "strMeasure\(index)"
            
            guard let ingredientKey = DynamicCodingKeys(stringValue: ingredientKeyString),
                  let measureKey = DynamicCodingKeys(stringValue: measureKeyString) else {
                continue
            }
            
            //Eğer ilgili alanlar varsa decode et, yoksa boş string döndür
            let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey) ?? ""
            let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey) ?? ""
            
            
            //boş veya sadece boşluk olan malzemeleri ekleme
            
            if !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                let combined = measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? ingredient : "\(measure) \(ingredient)"
                tempIngredients.append(combined)
            }
        }
        
        self.ingredients = tempIngredients
    }
    init(managedObject: NSManagedObject) {
        self.id = managedObject.value(forKey: "id") as? String ?? ""
        self.title = managedObject.value(forKey: "title") as? String ?? ""
        self.image = managedObject.value(forKey: "image") as? String ?? ""
        self.instructions = managedObject.value(forKey: "instructions") as? String ?? ""
        self.summary = managedObject.value(forKey: "summary") as? String ?? ""
        let ingredientsString = managedObject.value(forKey: "ingredients") as? String ?? ""
        self.ingredients = ingredientsString.isEmpty ? [] : ingredientsString.components(separatedBy: ", ")
    }
}
    
//Api yanıtını kapsayan model
struct MealResponse : Codable{
    let meals : [Meal]
}
