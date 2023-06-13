//
//  ListDetailView-ViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 28/04/2023.
//

import Foundation
import SwiftUI
import CoreData

class ListDetailViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    
    @Published var productToUpdate = ShopProduct()
    @Published var showUpdateItemView = false
    private var products: [ShopProduct] = []
    
    init(filter: String) {
        fetchData(filter: filter)
    }
    
    func fetchData(filter: String) {
        let request = NSFetchRequest<ShopProduct>(entityName: "ShopProduct")
        request.predicate = NSPredicate(format: "originList.listName == %@", filter)
        
        do {
            products = try viewContext.fetch(request)
        } catch {
            print("Kupa")
        }
    }
    
    func changeProductState(_ product: ShopProduct) {
        withAnimation {
            if product.completion {
                product.completion = false
                product.originList?.checkProduct -= 1
            } else {
                product.completion = true
                product.originList?.checkProduct += 1
            }
            try? self.viewContext.save()
        }
    }
    
    func setNewProduct(_ product: ShopProduct) {
        productToUpdate = product
    }
    
    func deleteItems(offsets: IndexSet) {
        for index in offsets {
            let item = products[index]
            if item.completion {
                products.first?.originList?.checkProduct -= 1
            }
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

