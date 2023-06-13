//
//  CreateNewRecipeView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 17/05/2023.
//

import SwiftUI

struct CreateNewRecipeView: View {
    @StateObject private var viewModel = CreateNewRecipeViewModel()
    @Environment(\.managedObjectContext) var moc
    @Binding var showAlert: Bool
    @Binding var showAddNewListView: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    TextField("Recipe name", text: $viewModel.name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                    
                    Button {
                        showAddNewListView = false
                        viewModel.saveNewRecipeToCore()
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



//struct CreateNewRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewRecipeView(showAlert: .constant(false))
//    }
//}
