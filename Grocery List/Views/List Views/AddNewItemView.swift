//
//  AddNewItemView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 28/04/2023.
//

import SwiftUI

struct AddNewItemView: View {
    
    @StateObject private var viewModel: AddNewItemViewModel
    @State var showAddItemView = false
    
    init(list: ShopList) {
        _viewModel = StateObject(wrappedValue: AddNewItemViewModel(list: list))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        if viewModel.searchText == "" {
                            ForEach(viewModel.categories) { category in
                                Section {
                                    ForEach(category.products) { singleProduct in
                                        Button {
                                            viewModel.admitProduct(product: singleProduct, productsCategory: category)
                                            showAddItemView = true
                                        } label: {
                                            HStack {
                                                Image(singleProduct.image)
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                
                                                Text(singleProduct.name)
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
                                    viewModel.createProductCategory(product: result)
                                    showAddItemView = true
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
                
                if showAddItemView {
                    BlankView()
                        .onTapGesture {
                            showAddItemView = false
                        }
                    AdvancedItemView(product: viewModel.choosenProduct!, list: viewModel.list, showAddItemView: $showAddItemView)
                }
            }
            .background {
                BackgroundView()
            }
        }
    }
}




//struct AddNewItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewItemView(, lisr: <#ShopList#>)
//    }
//}
