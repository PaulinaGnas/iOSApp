//
//  AddSingleIngredientView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 30/05/2023.
//

import SwiftUI
import Combine

struct AddIngredientView: View {
    @StateObject private var viewModel = AddIngredientViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var showwAddNetItemView = false
    var recipe: UserRecipe
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        if viewModel.searchText == "" {
                            ForEach(viewModel.categories) { category in
                                Section {
                                    ForEach(category.products) { product in
                                        Button {
                                            viewModel.addProductToRecipe(product)
                                            showwAddNetItemView = true
                                        } label: {
                                            HStack {
                                                Image(product.image)
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                
                                                Text(product.name)
                                                    .tint(Color.black)
                                            }
                                        }
                                    }
                                } header: {
                                    Text(category.section)
                                }
                            }
                        } else {
                            ForEach(viewModel.searchResults) { result in
                                Button {
                                    viewModel.addProductToRecipe(result)
                                    showwAddNetItemView = true
                                } label: {
                                    HStack {
                                        Image(result.image)
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                        
                                        Text(result.name)
                                            .tint(Color.black)
                                    }
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .navigationBarTitle("Search")
                    .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
                }
                if showwAddNetItemView {
                    BlankView()
                        .onTapGesture {
                            showwAddNetItemView = false
                        }
                    AddSingleIngredientView(product: viewModel.choosenProduct!, recipe: recipe, showAddView: $showwAddNetItemView)
                }
            }
            .background {
                Color(.purple)
                    .ignoresSafeArea(.all)
            }
        }
    }
}

//struct AddSingleIngredientView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddIngredientView()
//    }
//}
