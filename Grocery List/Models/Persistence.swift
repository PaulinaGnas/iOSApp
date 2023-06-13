//
//  Persistence.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import CoreData

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Grocery_List")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        
        
        for _ in 0..<4 {
            let product1 = ShopProduct(context: viewContext)
            product1.name = "Lemon"
            product1.amount = "5"
            product1.choosenUnit = "kg"
            product1.completion = false
            product1.id = UUID()
            product1.originList = ShopList(context: viewContext)
            product1.originList?.listName = "List of fruits"
            product1.originList?.checkProduct = Int16(0)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
