//
//  UpdateRecipeView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 18/05/2023.
//

import SwiftUI
import Combine

struct UpdateRecipeView: View {
    @StateObject private var viewModel: UpdateRecipeViewModel
    @State private var showingImagePicker = false
    @FetchRequest var recipe: FetchedResults<UserRecipe>
    
    init(filter: String, filterId: UUID) {
        _recipe = FetchRequest<UserRecipe>(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", filterId as CVarArg))
        _viewModel = StateObject(wrappedValue: UpdateRecipeViewModel(filter))
    }
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    ZStack {
                        Rectangle()
                            .fill(.secondary)
                        VStack {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                            
                            Text("Tap to select a picture")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        viewModel.image?
                            .resizable()
                            .scaledToFit()
                    }
                    .onTapGesture {
                        showingImagePicker = true
                    }
                } header: {
                    Text("Picture")
                }
                
                Section {
                    TextField(viewModel.recipe.unwrappedRecipeName, text: $viewModel.recipeNewName)
                    
                } header: {
                    Text("Recipe Name")
                }
                
                Section {
                    TextField("Minutes", text: $viewModel.newPreparationTimeAsString)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.newPreparationTimeAsString)) { newValue in
                            viewModel.checkInput(newValue)
                        }
                } header: {
                    Text("Preparation time (min)")
                }
                
                Section {
                    NavigationLink(destination: IngredientsView(recipe: recipe.first!)) {
                        Text("Ingredients: \(recipe.first!.unwrappedListOfIngredients.count)")
                    }
                } header: {
                    
                }
                
                Section {
                    TextField("Portions ", text: $viewModel.newServesAsString)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.newServesAsString)) { newValue in
                            viewModel.checkInput(newValue)
                        }
                } header: {
                    Text("Serves")
                }
                
                Section {
                    RatingView(rating: $viewModel.newRating)
                } header: {
                    Text("Rating")
                }
                
                Section {
                    TextField("Instructions", text: $viewModel.newInstructions, axis: .vertical)
                        .lineLimit(5...10)
                } header: {
                    Text("Instructions")
                }
                
                Section {
                    TextField("Notes", text: $viewModel.newNotes, axis: .vertical)
                        .lineLimit(2...10)
                } header: {
                    Text("Notes")
                }
                
            } //: FORM
            .modifier(RoundedBackgroundModifier())
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.loadImage()
            }
            .toolbar {
                Button {
                    viewModel.saveRecipeToCore()
                } label: {
                    Text("Save")
                }
            }
            .background {
                BackgroundView()
            }
        }
    }
}
