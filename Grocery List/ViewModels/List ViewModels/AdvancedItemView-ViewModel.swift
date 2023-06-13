//
//  AdvancedItemView-ViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 28/04/2023.
//

import Foundation

class AdvancedItemViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    
    @Published var amount = "1"
    @Published var unit = "kg"
    @Published var units = ["kg", "g", "l", "ml", "pct"]
    @Published var product: SingleProduct
    @Published var list: ShopList
    
    init(_ product: SingleProduct, _ list: ShopList) {
        self.product = product
        self.list = list
    }
    
    func addItemToList(product: SingleProduct, list: ShopList) {
        let newItem = ShopProduct(context: viewContext)
        newItem.name = product.name
        newItem.amount = amount
        newItem.image = product.image
        newItem.id = UUID()
        newItem.completion = false
        newItem.choosenUnit = unit
        newItem.originList = list
        newItem.originList?.listName = list.listName
        
        try? viewContext.save()
    }
    
    func verifyValue(_ newValue: String) {
        let filtered = newValue.filter { "0123456789".contains($0) }
        if filtered != newValue {
            amount = filtered
        }
    }
}



