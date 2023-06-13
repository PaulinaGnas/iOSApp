//
//  UpdateRecipeViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 18/05/2023.
//

import Foundation
import CoreData
import SwiftUI

class UpdateRecipeViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    @Published var recipeNewName = ""
    @Published var recipe = UserRecipe()
    @Published var ingredients = [UserIngredient]()
    @Published var newPreparationTimeAsString = ""
    @Published var newInstructions = ""
    @Published var newNotes = ""
    @Published var newRating = 0
    @Published var newServesAsString = ""
    @Published var image: Image?
    @Published var inputImage: UIImage?
    
    init(_ filter: String) {
        fetchData(filter)
        newPreparationTimeAsString = String(recipe.unwrappedPreparationTime)
        newInstructions = recipe.unwrappedInstructions
        newNotes = recipe.unwrappedNote
        recipeNewName = recipe.unwrappedRecipeName
        newRating = recipe.unwrappedRating
        newServesAsString = String(recipe.unwrappedServes)
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
    
    func saveRecipeToCore() {
        if inputImage != nil {
            let pickedImage = inputImage?.jpegData(compressionQuality: 0.8)
            recipe.image = pickedImage
        }
        recipe.recipeName = recipeNewName
        recipe.instructions = newInstructions
        recipe.note = newNotes
        recipe.preparationTime = Int16(newPreparationTimeAsString) ?? Int16(0)
        recipe.rating = Int16(newRating)
        recipe.serves = Int16(newServesAsString) ?? Int16(0)
        
        saveData()
    }
    
    func saveData() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func checkInput(_ newValue: String) {
        let filtered = newValue.filter { "0123456789".contains($0) }
        if filtered != newValue {
            newPreparationTimeAsString = filtered
        }
    }
}
