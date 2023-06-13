//
//  UpdateItemView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 09/05/2023.
//

import SwiftUI
import Combine

struct UpdateItemView: View {
    @StateObject private var viewModel: UpdateItemViewModel
    @Binding var showUpdateItemView: Bool
    
    init(product: ShopProduct, showUpdateItemView: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: UpdateItemViewModel(product))
        self._showUpdateItemView = showUpdateItemView
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Text(viewModel.product.unwrappedName)
                        .fontWeight(.semibold)
                    HStack {
                        TextField("Amount", text: $viewModel.amount)
                            .frame(height: 1)
                            .keyboardType(.numberPad)
                            .onReceive(Just(viewModel.amount)) { newValue in
                                viewModel.validateInput(newValue)
                            }
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                        
                        Picker("Choose unit", selection: $viewModel.unit) {
                            ForEach(viewModel.units, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.inline)
                    }
                    
                    Button {
                        viewModel.updateItemInCore()
                        showUpdateItemView = false
                        
                    } label: {
                        Text("Add")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
                            .foregroundColor(.white)
                            .background {
                                BackgroundButtonView()
                            }
                            .cornerRadius(9)
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

struct UpdateItemView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateItemView(product: ShopProduct(), showUpdateItemView: .constant(false))
    }
}
