//
//  ContentView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ListsView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Lists")
                }
            
            RecipesView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Recipes")
                }
        }
        .tint(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
