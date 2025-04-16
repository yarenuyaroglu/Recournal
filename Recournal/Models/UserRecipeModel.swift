//
//  UserRecipeModel.swift
//  Recournal
//
//  Created by YarenEteration on 9.04.2025.
//
import Foundation
import UIKit

// Kullanıcı eklediği tarifi temsil eden model (benzersiz id oluşturuluyor)
struct UserRecipeModel {
    let id: String//UUID yap
    let title: String
    let ingredients: String
    let instructions: String
    let image: UIImage?
}

// AddRecipeViewController’dan veri geri aktarmak için delegate protokolü
protocol AddRecipeDelegate: AnyObject { //Sadece class türleri tarafından benimsenebilir(bellek yönetimini kolaylaştırmak için)
    func didAddRecipe(_ recipe: UserRecipeModel)
}
