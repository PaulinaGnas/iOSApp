//
//  AddNewItemView-ViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 28/04/2023.
//

import Foundation

class AddNewItemViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var categories: [Category] = Bundle.main.decode("shopItems.json")
    @Published var choosenProduct: SingleProduct?
    @Published var list: ShopList
    
    init(list: ShopList) {
        self.list = list
    }
    
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
    
    func createProductCategory(product: SingleProduct) {
        choosenProduct = product
    }
    
    func admitProduct(product: SingleProduct, productsCategory: Category) {
        choosenProduct = product
    }
}

