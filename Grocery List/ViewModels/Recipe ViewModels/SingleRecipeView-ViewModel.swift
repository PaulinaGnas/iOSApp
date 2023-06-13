//
//  SingleRecipeView-ViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 18/05/2023.
//

import Foundation
import CoreData
import SwiftUI

class SingleRecipeViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext

    @Published var recipe = UserRecipe()
    @Published var rating = 0
    
    @Published var image: Image?
    @Published var inputImage = UIImage(systemName: "xmark")
    
    init(filter: String) {
        fetchData(filter)
        rating = recipe.unwrappedRating
    }
    
    func fetchData(_ filter: String) {
        let request = NSFetchRequest<UserRecipe>(entityName: "UserRecipe")
        request.predicate = NSPredicate(format: "recipeName == %@", filter)
        
        do {
            let recipes = try viewContext.fetch(request)
            if recipes.first != nil {
                recipe = recipes.first!
            }
        } catch {
            print("Nołp")
        }
    }
   
    func loadImage() {
        guard let inputImage = recipe.image else { return }
        image = Image(uiImage: UIImage(data: inputImage)!)
    }
}
