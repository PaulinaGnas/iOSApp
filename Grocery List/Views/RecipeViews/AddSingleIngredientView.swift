//
//  AddSingleIngredientView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 30/05/2023.
//

import SwiftUI
import Combine

struct AddSingleIngredientView: View {
    @StateObject private var viewModel: AddSingleIngredientViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var showAddView: Bool
    
    init(product: SingleProduct, recipe: UserRecipe, showAddView: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: AddSingleIngredientViewModel(product, recipe))
        self._showAddView = showAddView
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
                        TextField("Quantity", text: $viewModel.quantity)
                            .frame(height: 1)
                            .keyboardType(.numberPad)
                            .onReceive(Just(viewModel.quantity)) { newValue in
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
                        viewModel.addItemToRecipe()
                        showAddView = false
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
