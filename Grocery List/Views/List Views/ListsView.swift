//
//  ListsView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import SwiftUI

struct ListsView: View {
    @StateObject private var viewModel = ListsViewModel()
    @FetchRequest(sortDescriptors: [SortDescriptor(\.listName)]) private var listy: FetchedResults<ShopList>
    @State var showAlert = false
    
    var dupa = "Duap"
 
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Text("My lists")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        EditButton()
                            .padding(10)
                            .foregroundColor(.white)
                            .background {
                                Capsule()
                                    .stroke(.white, lineWidth: 2)
                            }
                        Button {
                            
                        } label: {
                            Image(systemName: "paintbrush")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    Button {
                        viewModel.showAddNewList = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                                .tint(.white)
                            
                            Text("Add new list")
                                .font(.system(size: 25, design: .rounded))
                                .fontWeight(.bold)
                                .tint(.white)
                        }
                        .padding()
                        .background {
                            BackgroundButtonView().clipShape(Capsule())
                                
                        }
                    }
                    Spacer()
                    if listy.count != 0 {
                        List {
                            ForEach(listy) { list in
                                LineView(list: list)
                            }
                            .onDelete(perform: viewModel.deleteKupas)
                        }
                        .scrollContentBackground(.hidden)
                    } else {
                        Text("Add list")
                        Spacer()
                    }
                }
                if viewModel.showAddNewList {
                    BlankView()
                        .onTapGesture {
                            viewModel.showAddNewList = false
                        }
                    AddNewListView(showAddNewListView: $viewModel.showAddNewList, showAlert: $showAlert)
                }
            }
            .background {
                BackgroundView()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Wrong name"), message: Text("List name must be unique"), dismissButton: .default(Text("Got it")))
        }
    }
}


struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
