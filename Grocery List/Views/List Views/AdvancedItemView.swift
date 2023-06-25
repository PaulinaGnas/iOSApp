//
//  AdvancedItemView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 28/04/2023.
//

import SwiftUI
import Combine

struct AdvancedItemView: View {
    @StateObject private var viewModel: AdvancedItemViewModel
    @Binding var showAddItemView: Bool
    
    init(product: SingleProduct, list: ShopList, showAddItemView: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: AdvancedItemViewModel(product, list))
        self._showAddItemView = showAddItemView
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Text(viewModel.product.name)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    HStack {
                        TextField("Amount", text: $viewModel.amount)
                            .frame(height: 1)
                            .keyboardType(.numberPad)
                            .onReceive(Just(viewModel.amount)) { newValue in
                                viewModel.verifyValue(newValue)
                            }
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                            .foregroundColor(.black)
                        
                        Picker("Choose unit", selection: $viewModel.unit) {
                            ForEach(viewModel.units, id: \.self) {
                                Text($0)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.inline)
                    }
                    
                    Button {
                        viewModel.addItemToList(product: viewModel.product, list: viewModel.list)
                        showAddItemView = false
                        
                    } label: {
                        Text("Add")
                            .modifier(SquareButtonModifier())
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(9)
                .frame(height: 200)
                Spacer()
            }
            .padding()
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
        }
    }
}
