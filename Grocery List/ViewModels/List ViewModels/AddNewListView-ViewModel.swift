//
//  AddNewListView-ViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import Foundation
import CoreData


class AddNewListViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.container.viewContext
    
    @Published var listName = "New List"
    @Published var showAlert = false
    @Published var existingLists: [ShopList] = []
    @Published var dupa = false
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let request = NSFetchRequest<ShopList>(entityName: "ShopList")
        
        do {
            existingLists = try viewContext.fetch(request)
        } catch {
            print("Dupa")
        }
    }
    
    func createList(name: String) {
        if !existingLists.contains(where: { $0.unwrappedName == name }) {
            let list = ShopList(context: viewContext)
            list.listName = name
            list.id = UUID()
            
            saveData()
        } else {
            showAlert = true
            dupa.toggle()
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
}

