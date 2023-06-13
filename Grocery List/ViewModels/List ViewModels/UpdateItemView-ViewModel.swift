//
//  UpdateItemView-ViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 09/05/2023.
//

import Foundation

class UpdateItemViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    
    @Published var units = ["kg", "g", "l", "ml", "pct"]
    @Published var unit = "kg"
    @Published var amount = "1"
    @Published var product: ShopProduct
    
    init(_ product: ShopProduct) {
        self.product = product
    }
    
    func updateItemInCore() {
        if product.amount != amount || product.choosenUnit != unit {
            product.amount = amount
            product.choosenUnit = unit
            
            if product.completion {
                product.originList?.checkProduct -= 1
                product.completion = false
            }
        }
        
        try? viewContext.save()
    }
    
    func changeAmount(_ amount: String) {
        self.amount = amount
    }
    
    func validateInput(_ value: String) {
        let filtered = value.filter { "0123456789".contains($0) }
        if filtered != value {
            changeAmount(filtered)
        }
    }
}

