//
//  ListsView-ViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import Foundation
import CoreData

class ListsViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    @Published var showAddNewList = false
    private var lists: [ShopList] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let request = NSFetchRequest<ShopList>(entityName: "ShopList")
        
        do {
            lists = try viewContext.fetch(request)
        } catch {
            print("Dupa")
        }
    }
    
    func deleteKupas(offsets: IndexSet) {
        offsets.map { lists[$0] }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

