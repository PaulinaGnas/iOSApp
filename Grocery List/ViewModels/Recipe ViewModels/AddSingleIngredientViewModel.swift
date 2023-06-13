//
//  AddSingleIngredientViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 30/05/2023.
//

import Foundation

class AddSingleIngredientViewModel: ObservableObject {
    
    private var moc = PersistenceController.shared.container.viewContext
    
    @Published var quantity = "1"
    @Published var unit = "kg"
    @Published var units = ["kg", "g", "l", "ml", "pct"]
    @Published var product: SingleProduct
    @Published var recipe: UserRecipe
    
    init(_ product: SingleProduct, _ recipe: UserRecipe) {
        self.product = product
        self.recipe = recipe
    }
    
    func addItemToRecipe() {
        let newIngred = UserIngredient(context: moc)
        newIngred.name = product.name
        newIngred.id = UUID()
        newIngred.parentRecipe = recipe
        newIngred.quantity = quantity
        newIngred.unit = unit
        newIngred.image = product.image
        
        try? moc.save()
    }
    
    func verifyValue(_ newValue: String) {
        let filtered = newValue.filter { "0123456789".contains($0) }
        if filtered != newValue {
            quantity = filtered
        }
    }
}
