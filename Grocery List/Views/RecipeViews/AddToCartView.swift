//
//  AddToCartView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 13/06/2023.
//

import SwiftUI

struct AddToCartView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.listName)]) var lists: FetchedResults<ShopList>
    @Environment(\.dismiss) private var dismiss
    var ingredients: FetchedResults<UserIngredient>
    var moc = PersistenceController.shared.container.viewContext
    
    @State private var selectedList = ShopList()
    
    func save(to list: ShopList) {
        for ing in ingredients {
            let newItem = ShopProduct(context: moc)
            newItem.id = UUID()
            newItem.name = ing.name
            newItem.amount = ing.quantity
            newItem.image = ing.image
            newItem.completion = false
            newItem.choosenUnit = ing.unit
            newItem.originList = list
            newItem.originList?.listName = list.listName
        }
        
        do {
            try moc.save()
        } catch {
            print("Nope")
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Choose list", selection: $selectedList) {
                    ForEach(lists) { list in
                        Text(list.unwrappedName).tag(list)
                            .foregroundColor(Color(UIColor(named: "fontColor")!))
                    }
                }
                .pickerStyle(.menu)
                .foregroundColor(Color(UIColor(named: "fontColor")!))
                
                Button {
                    save(to: selectedList)
                    dismiss()
                } label: {
                    Text("Save")
                        .foregroundColor(Color(UIColor(named: "fontColor")!))
                }
            }
        }
        .foregroundColor(.black)
    }
}
