//
//  RecipeDetailViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 19/05/2023.
//

import Foundation
import CoreData
import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    private var recipes: [UserRecipe] = []

    @Published var recipe = UserRecipe()
    @Published var image: Image?
    @Published var inputImage = UIImage(systemName: "xmark")
    @Published var addToCart = false
    
    init(filter: String) {
        fetchData(filter)
    }
    
    func fetchData(_ filter: String) {
        let request = NSFetchRequest<UserRecipe>(entityName: "UserRecipe")
        request.predicate = NSPredicate(format: "recipeName == %@", filter)
        do {
            recipes = try viewContext.fetch(request)
            recipe = recipes.first!
        } catch {
            print("Nope")
        }
    }
    
    func loadImage() {
        guard let inputImage = recipe.image else { return }
        image = Image(uiImage: UIImage(data: inputImage)!)
    }
}
