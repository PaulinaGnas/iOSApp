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
                    TextField("Minutes: ", text: $viewModel.newServesAsString)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.newServesAsString)) { newValue in
                            viewModel.checkInput(newValue)
                        }
                } header: {
                    Text("Serves")
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
        //        VStack {
        //            ZStack {
        //                Rectangle()
        //                    .fill(.secondary)
        //                VStack {
        //                    Image(systemName: "camera")
        //                        .resizable()
        //                        .scaledToFit()
        //                        .foregroundColor(.white)
        //                        .frame(width: 50, height: 50)
        //
        //                    Text("Tap to select a picture")
        //                        .foregroundColor(.white)
        //                        .font(.headline)
        //                }
        //                viewModel.image?
        //                    .resizable()
        //                    .scaledToFit()
        //            }
        //            .onTapGesture {
        //                showingImagePicker = true
        //            }
        //            .frame(width: 200, height: 100)
        //
        //            VStack(alignment: .leading) {
        //                Text("Recipe Name")
        //                    .font(.footnote)
        //                TextField(viewModel.recipe.unwrappedRecipeName, text: $viewModel.recipeNewName)
        //                Divider()
        //            }
        //        }
        //        .padding([.horizontal, .bottom])
        //        ZStack {
        //            ScrollView(.vertical) {
        //                VStack(alignment: .leading) {
        //                    HStack {
        //                        ZStack {
        //                            Rectangle()
        //                                .frame(width: 130, height: 60)
        //                            Rectangle()
        //                                .foregroundColor(.purple)
        //                                .frame(width: 120, height: 50)
        //                            Rectangle()
        //                                .foregroundColor(.purple)
        //                                .frame(width: 100, height: 60)
        //                            Text("Add Photo")
        //
        //                            viewModel.image?
        //                                .resizable()
        //                                .scaledToFit()
        //                        } //: ZSTACK
        //                        .onTapGesture {
        //                            showingImagePicker = true
        //                        }
        //                        VStack(alignment: .leading) {
        //                            Text("Recipe Name")
        //                                .font(.footnote)
        //                            TextField(viewModel.recipe.unwrappedRecipeName , text: $viewModel.recipeNewName)
        //                            Divider()
        //                        }
        //                    } //: HSTACK
        //
        //                    HStack {
        //                        NavigationLink(destination: IngredientsView(recipe: recipe.first!)) {
        //                            HStack {
        //                                Image(systemName: "leaf.fill")
        //                                    .resizable()
        //                                    .frame(width: 25, height: 25)
        //                                Text("Ingredients: \(recipe.first!.unwrappedListOfIngredients.count)")
        //                                Spacer()
        //                                Image(systemName: "chevron.right")
        //                                    .resizable()
        //                                    .scaledToFit()
        //                                    .frame(width: 15, height: 15)
        //                                    .foregroundColor(.black)
        //                            }
        //                        }
        //                    }
        //                    HStack {
        //                        Image(systemName: "clock.fill")
        //                            .resizable()
        //                            .frame(width: 25, height: 25)
        //                        Text("Preparation Time: ")
        //                        TextField("Minutes", text: $viewModel.newPreparationTimeAsString)
        //                            .keyboardType(.numberPad)
        //                            .onReceive(Just(viewModel.newPreparationTimeAsString)) { newValue in
        //                                viewModel.checkInput(newValue)
        //                            }
        //                    }
        //                    HStack {
        //                        Image(systemName: "person.2.fill")
        //                            .resizable()
        //                            .frame(width: 25, height: 25)
        //
        //                        Text("Serves: ")
        //                        TextField("Minutes: ", text: $viewModel.newServesAsString)
        //                            .keyboardType(.numberPad)
        //                            .onReceive(Just(viewModel.newServesAsString)) { newValue in
        //                                viewModel.checkInput(newValue)
        //                            }
        //                    }
        //                    HStack {
        //                        Image(systemName: "pencil.circle.fill")
        //                            .resizable()
        //                            .frame(width: 25, height: 25)
        //                        Text("Instructions: ")
        //                        TextField("Instructions", text: $viewModel.newInstructions, axis: .vertical)
        //                            .lineLimit(5...10)
        //                    }
        //                    HStack {
        //                        Image(systemName: "star.fill")
        //                            .resizable()
        //                            .frame(width: 25, height: 25)
        //                        Text("Rating: ")
        //                        RatingView(rating: $viewModel.newRating)
        //                    }
        //                    HStack {
        //                        Image(systemName: "highlighter")
        //                            .resizable()
        //                            .frame(width: 25, height: 25)
        //                        Text("Notes: ")
        //                        TextField("Notes", text: $viewModel.newNotes, axis: .vertical)
        //                            .lineLimit(2...10)
        //                    }
        //                    .padding()
        //                } //: VSTACK
        //                .padding()
        //            } //: SCROLLVIEW
        //            .sheet(isPresented: $showingImagePicker) {
        //                ImagePicker(image: $viewModel.inputImage)
        //            }
        //            .onChange(of: viewModel.inputImage) { _ in
        //                viewModel.loadImage()
        //            }
        //        } //: ZSTACK
        //        .background {
        //            Color.purple.ignoresSafeArea()
        //        }
        //        .toolbar {
        //            Button {
        //                viewModel.saveRecipeToCore()
        //            } label: {
        //                Text("Save")
        //            }
        //        }
    }
}

//struct UpdateRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateRecipeView(filter: "")
//    }
//}
