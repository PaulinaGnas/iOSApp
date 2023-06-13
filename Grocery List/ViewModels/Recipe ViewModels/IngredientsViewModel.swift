//
//  AddIngredientsViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 18/05/2023.
//

import Foundation
import CoreData

class IngredientsViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    
    private var products: [UserIngredient] = []
    
    init(filter: String) {
        fetchData(filter)
    }
    
    func fetchData(_ filter: String) {
        let request = NSFetchRequest<UserIngredient>(entityName: "UserIngredient")
        request.predicate = NSPredicate(format: "parentRecipe.recipeName == %@", filter)

        
        do {
            products = try viewContext.fetch(request)
        } catch {
            print("Kupa")
        }
    }
    
    func deleteIngredient(offsets: IndexSet) {
        for index in offsets {
            let item = products[index]
            viewContext.delete(item)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
