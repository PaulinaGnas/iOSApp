//
//  CreateNewRecipeViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 18/05/2023.
//

import Foundation
import CoreData

class CreateNewRecipeViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    @Published var name = ""
    @Published var existingRecipes: [UserRecipe] = []
    @Published var showAlert = false
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let request = NSFetchRequest<UserRecipe>(entityName: "UserRecipe")
        do {
            existingRecipes = try viewContext.fetch(request)
        } catch {
            print("Nope")
        }
    }

    func saveData() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func saveNewRecipeToCore() {
        if !existingRecipes.contains(where: { $0.unwrappedRecipeName == name }) {
            let newRecipe = UserRecipe(context: viewContext)
            newRecipe.recipeName = name
            newRecipe.id = UUID()
            saveData()
        } else {
            showAlert = true
        }
    }
}
