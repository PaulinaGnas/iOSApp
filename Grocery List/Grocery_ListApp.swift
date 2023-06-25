//
//  Grocery_ListApp.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import SwiftUI

@main
struct Grocery_ListApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("DarkAppearance") var darkAppearance = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(darkAppearance ? .dark : .light)
        }
    }
}
