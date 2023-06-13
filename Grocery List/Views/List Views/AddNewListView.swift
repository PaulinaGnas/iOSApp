//
//  AddNewListView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import SwiftUI

struct AddNewListView: View {
    @StateObject private var viewModel = AddNewListViewModel()
    @Binding var showAddNewListView: Bool
    @Binding var showAlert: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    TextField("List name", text: $viewModel.listName)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                    
                    Button {
                        showAddNewListView = false
                        viewModel.createList(name: viewModel.listName)
                        showAlert = viewModel.showAlert
                    } label: {
                        Text("Save")
                            .modifier(SquareButtonModifier())
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(9)
            }
            .padding()
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
        }
    }
}

struct AddNewListView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewListView(showAddNewListView: .constant(false), showAlert: .constant(false))
    }
}
