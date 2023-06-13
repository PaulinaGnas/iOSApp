//
//  RecipesView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import SwiftUI

struct RecipesView: View {
    @State var showAlert = false
    @State var showAddNewListView = false
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<UserRecipe>
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical) {
                    ForEach(recipes, id: \.self) { recipe in
                        NavigationLink(destination: RecipeDetailView(filter: recipe.unwrappedRecipeName)) {
                            SingleRecipeView(filter: recipe.unwrappedRecipeName)
                        }
                    } //: FOREACH
                } //: SCROLLVIEW
                .padding(.vertical, 10)
                
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("")
                        Button {
                            showAddNewListView = true
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 60, height: 60)
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            } //: ZSTACK
                        }
                    } //: VSTACK
                } //: HSTACK
                .padding(10)
                if showAddNewListView {
                    BlankView()
                        .onTapGesture {
                            showAddNewListView = false
                        }
                    CreateNewRecipeView(showAlert: $showAlert, showAddNewListView: $showAddNewListView)
                }
            } //: ZSTACK
            .navigationTitle("Your recipes")
            .background {
                BackgroundView()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Wrong name"), message: Text("Recipe name must be unique"), dismissButton: .default(Text("Got it")))
            }
        } //: NAVIGATIONSTACK
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
