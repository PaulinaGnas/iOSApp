//
//  AddIngredientViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 30/05/2023.
//

import Foundation

class AddIngredientViewModel: ObservableObject {
    @Published var categories: [Category] = Bundle.main.decode("shopItems.json")
    @Published var searchText = ""
    @Published var choosenProduct: SingleProduct?
    
    var searchResults: [SingleProduct] {
        if searchText.isEmpty {
            let allCategories = categories.flatMap {
                $0.products.map { $0 }
            }
            return allCategories
        } else {
            var allCategories = categories.flatMap {
                $0.products.filter { $0.name.contains(searchText)}
            }
            if allCategories == [] {
                allCategories = [SingleProduct(name: searchText, image: "basket")]
            }
            return allCategories
        }
    }
    
    func addProductToRecipe(_ product: SingleProduct) {
        choosenProduct = product
    }
}
