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
}
