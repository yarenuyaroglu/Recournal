//
//  CoreDataManager.swift
//  Recournal
//
//  Created by YarenEteration on 7.04.2025.
//
import Foundation
import CoreData


class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    //NSPersistentContainer : Core Data Yığını
    let persistentContainer : NSPersistentContainer
    
    private init () {
        persistentContainer = NSPersistentContainer(name: "Recournal")
        persistentContainer.loadPersistentStores {
            description, error in if let error = error {
                fatalError("Core Data store yüklenmedi : \(error)")
            }
        }
    }
    
    
    var context : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    
    //Save Fonksiyonu
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data yüklenirken hata oluştu: \(error) ")
            }
        }
    }
    
    
    //Favorites
    func addToFavorites(meal: Meal){
        guard let entity = NSEntityDescription.entity(forEntityName: "Meals", in: self.context) else {
            print("Not found the Meals entity!")
            return
        }
        
        
        let favoriteMeal = NSManagedObject(entity: entity, insertInto: self.context)
        
        
        //Meal dtaa modelindeki attribute'lar Core Data attribute'ların aktarmak
        favoriteMeal.setValue(meal.id, forKey: "id")
        favoriteMeal.setValue(meal.title, forKey: "title")
        favoriteMeal.setValue(meal.image, forKey: "image")
        favoriteMeal.setValue(meal.summary, forKey: "summary")
        favoriteMeal.setValue(meal.instructions, forKey: "instructions")
        
        //ingredients dizini virgülle ayrılmış bir stringe çevir
        favoriteMeal.setValue(meal.ingredients.joined(separator: ", "), forKey: "ingredients")
        
        
        do {
            try self.context.save()
            print("Meal favorilere eklendi.")
        }
        catch{
            print("Meal favorilere eklenemedi.")
        }
    }
}
