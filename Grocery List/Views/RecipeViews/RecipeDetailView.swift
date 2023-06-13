//
//  RecipeDetailView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 17/05/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel: RecipeDetailViewModel
    @FetchRequest var ingredients: FetchedResults<UserIngredient>
    
    init(filter: String) {
        _ingredients = FetchRequest<UserIngredient>(sortDescriptors: [], predicate: NSPredicate(format: "parentRecipe.recipeName == %@", filter))
        _viewModel = StateObject(wrappedValue: RecipeDetailViewModel(filter: filter))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical) {
                    VStack {
                        viewModel.image?
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 15)
                            .padding(5)
                        
                        Group {
                            Text(viewModel.recipe.unwrappedRecipeName)
                                .font(.system(.largeTitle, design: .serif))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top, 10)
                            
                            RatingView(rating: .constant(viewModel.recipe.unwrappedRating))
                            
                            HStack(alignment: .center, spacing: 12) {
                                HStack {
                                    Image(systemName: "person.2")
                                    Text("Serves: \(viewModel.recipe.unwrappedServes)")
                                }
                                HStack {
                                    Image(systemName: "clock")
                                    Text("Prep: \(viewModel.recipe.unwrappedPreparationTime)")
                                }
                                HStack {
                                    Image(systemName: "leaf")
                                    Text("Ingreds: \(viewModel.recipe.unwrappedListOfIngredients.count)")
                                }
                            }
                            .font(.footnote)
                            .foregroundColor(.gray)
                            
                            Text("Ingredients")
                                .modifier(TitleModifier())
                            
                            if ingredients.count != 0 {
                                VStack(alignment: .leading, spacing: 5) {
                                    ForEach(ingredients) { ing in
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("\(ing.unwrappedQuantity) \(ing.unwrappedUnit) \(ing.unwrappedIngredientName)")
                                                .font(.footnote)
                                            Divider()
                                        }
                                    }
                                }
                            } else {
                                Text("No ingredients")
                            }
                            Text("Instructions")
                                .modifier(TitleModifier())
                            Text(viewModel.recipe.unwrappedInstructions)
                        
                            Text("Notes")
                                .modifier(TitleModifier())
                            Text(viewModel.recipe.unwrappedNote)
                        } //: GROUP
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .onAppear {
                            viewModel.loadImage()
                            if viewModel.image == nil {
                                viewModel.image = Image("avocado-toast-bacon")
                            }
                        }
                        
                    } //: VSTACK
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: UpdateRecipeView(filter: viewModel.recipe.unwrappedRecipeName, filterId: viewModel.recipe.id!)) {
                                Text("Edit recipe")
                            }
                        }
                    }
                    
                    .background {
                        Color.white
                    }
                    .padding(.bottom, 10)
                } //: SCROLLVIEW
                .modifier(RoundedBackgroundModifier())
            } //: ZSTACK
            .background {
                BackgroundView()
            }
        } //: NAVIGATIONSTACK
    }
}

//struct RecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailView()
//    }
//}
