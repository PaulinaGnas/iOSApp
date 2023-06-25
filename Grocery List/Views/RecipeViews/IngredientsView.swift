//
//  AddIngredientsView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 17/05/2023.
//

import SwiftUI

struct IngredientsView: View {
    @StateObject private var viewModel: IngredientsViewModel
    var recipe: UserRecipe
    @FetchRequest var ingreds: FetchedResults<UserIngredient>
    @Environment(\.managedObjectContext) var viewContext

    init(recipe: UserRecipe) {
        self.recipe = recipe
        _ingreds = FetchRequest<UserIngredient>(sortDescriptors: [], predicate: NSPredicate(format: "parentRecipe.id == %@", recipe.id! as CVarArg))
        _viewModel = StateObject(wrappedValue: IngredientsViewModel(filter: recipe.unwrappedRecipeName))
    }
    
    func deleteIngredient(offsets: IndexSet) {
        offsets.map { ingreds[$0] }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if ingreds.count == 0 {
                        Text("Tap on + button to start adding ingredients to this recipe.")
                } else {
                    List {
                        ForEach(ingreds) { ing in
                            HStack {
                                Image(ing.unwrappedImage)
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text("\(ing.unwrappedQuantity) \(ing.unwrappedUnit)  \(ing.unwrappedIngredientName)")
                            }
                        }
                        .onDelete(perform: deleteIngredient)
                    }
                    .scrollContentBackground(.hidden)
                    .padding(0)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            AddIngredientView(recipe: recipe)
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 60, height: 60)
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            } //: ZSTACK
                            .padding()
                        } //: BUTTON
                    }
                }
            } //: ZSTACK
            .background {
                BackgroundView()
            }
        }
    }
}
