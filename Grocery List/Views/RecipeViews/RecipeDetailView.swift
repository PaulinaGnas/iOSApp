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
    @FetchRequest var recipe: FetchedResults<UserRecipe>

    init(filter: String) {
        _ingredients = FetchRequest<UserIngredient>(sortDescriptors: [], predicate: NSPredicate(format: "parentRecipe.recipeName == %@", filter))
        _viewModel = StateObject(wrappedValue: RecipeDetailViewModel(filter: filter))
        _recipe = FetchRequest<UserRecipe>(sortDescriptors: [], predicate: NSPredicate(format: "recipeName == %@", filter))
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
                            Text(recipe.first!.unwrappedRecipeName)
                                .font(.system(.largeTitle, design: .serif))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top, 10)
                            
                            RatingView(rating: .constant(recipe.first!.unwrappedRating))
                            
                            HStack(alignment: .center, spacing: 12) {
                                HStack {
                                    Image(systemName: "person.2")
                                    Text("Serves: \(recipe.first!.unwrappedServes)")
                                }
                                HStack {
                                    Image(systemName: "clock")
                                    Text("Prep: \(recipe.first!.unwrappedPreparationTime)")
                                }
                                HStack {
                                    Image(systemName: "leaf")
                                    Text("Ingreds: \(recipe.first!.unwrappedListOfIngredients.count)")
                                }
                            }
                            .font(.footnote)
                            .foregroundColor(Color(UIColor(named: "fontColor")!))
                            
                            HStack {
                                Text("Ingredients")
                                    .modifier(TitleModifier())
                                NavigationLink(destination: AddToCartView(ingredients: ingredients)) {
                                    Image(systemName: "cart.badge.plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color(UIColor(named: "fontColor")!))
                                }
                            }
                            
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
                            Text(recipe.first!.unwrappedInstructions)
                        
                            Text("Notes")
                                .modifier(TitleModifier())
                            Text(recipe.first!.unwrappedNote)
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
                            NavigationLink(destination: UpdateRecipeView(filter: recipe.first!.unwrappedRecipeName, filterId: recipe.first!.id!)) {
                                Text("Edit recipe")
                            }
                        }
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
