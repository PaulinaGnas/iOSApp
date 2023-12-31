//
//  ListDetailView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import SwiftUI

struct ListDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ListDetailViewModel
    @State var showUpdateItemView = false
    
    @FetchRequest var list: FetchedResults<ShopList>
    @FetchRequest var products: FetchedResults<ShopProduct>
    
    init(filter: String, listFilter: String) {
        _products = FetchRequest<ShopProduct>(sortDescriptors: [SortDescriptor(\.name)], predicate: NSPredicate(format: "originList.listName == %@", filter))
        _list = FetchRequest<ShopList>(sortDescriptors: [], predicate: NSPredicate(format: "listName == %@", listFilter))
        _viewModel = StateObject(wrappedValue: ListDetailViewModel(filter: filter))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Text(list.first?.unwrappedName ?? "No Name")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        Spacer()
                        EditButton()
                            .padding(10)
                            .foregroundColor(Color(UIColor(named: "fontColor") ?? .black))
                            .background {
                                Capsule()
                                    .stroke(Color(UIColor(named: "fontColor") ?? .black), lineWidth: 2)
                            }
                    }
                    .padding()
                    
                    if !products.isEmpty {
                        List {
                            ForEach(products) { product in
                                HStack {
                                    Image(systemName: product.completion ? "checkmark.square.fill" : "square")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.gray)
                                        .onTapGesture {
                                            viewModel.changeProductState(product)
                                        }
                                    
                                    HStack {
                                        Image(product.unwrappedImage)
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                        Text(product.unwrappedName)
                                        
                                        Spacer()
                                        
                                        ZStack {
                                            Color(UIColor.tertiarySystemFill)
                                                .frame(minWidth: 80, idealWidth: 80, maxWidth: 100, minHeight: 35)
                                                .cornerRadius(12)
                                            Text("\(product.unwrappedAmount) \(product.unwrappedUnit)")
                                        }
                                        .padding(.trailing, 5)
                                    }
                                    .onTapGesture {
                                        viewModel.setNewProduct(product)
                                        showUpdateItemView = true
                                    }
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .scrollContentBackground(.hidden)
                        .shadow(radius: 9)
                    } else {
                        Text("")
                        Spacer()
                    }
                    
                    NavigationLink(destination: AddNewItemView(list: list.first!)) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .tint(.white)
                            Text("Add new item")
                                .font(.system(size: 25, design: .rounded))
                                .fontWeight(.bold)
                                .tint(.white)
                        }
                        .padding()
                        .background {
                            BackgroundButtonView().clipShape(Capsule())
                        }
                    }
                    .padding(.bottom, 20)
                }
                if showUpdateItemView {
                    BlankView()
                        .onTapGesture {
                            showUpdateItemView = false
                        }
                    UpdateItemView(product: viewModel.productToUpdate, showUpdateItemView: $showUpdateItemView)
                }
            }
            .background(BackgroundView())
        }
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
