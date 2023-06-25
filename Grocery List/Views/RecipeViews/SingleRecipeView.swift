//
//  SingleRecipeView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 17/05/2023.
//

import SwiftUI

struct SingleRecipeView: View {
    @StateObject private var viewModel: SingleRecipeViewModel
    @FetchRequest var recipe: FetchedResults<UserRecipe>
    
    init(filter: String) {
        _recipe = FetchRequest<UserRecipe>(sortDescriptors: [], predicate: NSPredicate(format: "recipeName == %@", filter))
        _viewModel = StateObject(wrappedValue: SingleRecipeViewModel(filter: filter))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            viewModel.image?
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 12) {
                Text(recipe.first?.unwrappedRecipeName ?? "No name")
                    .font(.system(.title, design: .serif))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(Color(UIColor(named: "fontColor")!))
                
                RatingView(rating: .constant(recipe.first!.unwrappedRating))
                
                HStack(alignment: .center, spacing: 12) {
                    HStack {
                        Image(systemName: "person.2")
                        Text("Serves: \(recipe.first?.unwrappedServes ?? 0)")
                            
                    }
                    HStack {
                        Image(systemName: "clock")
                        Text("Prep: \(recipe.first?.unwrappedPreparationTime ?? 0)")
                    }
                    HStack {
                        Image(systemName: "leaf")
                        Text("Ingreds: \(recipe.first!.unwrappedListOfIngredients.count)")
                    }
                }
                .font(.footnote)
                .foregroundColor(Color(UIColor(named: "fontColor")!))
            }
            .padding()
            .padding(.bottom, 12)
        }
        .modifier(RoundedBackgroundModifier())
        .onAppear {
            viewModel.loadImage()
            if viewModel.image == nil {
                viewModel.image = Image("avocado-toast-bacon")
            }
        }
    }
}

struct SingleRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        SingleRecipeView(filter: "")
    }
}
