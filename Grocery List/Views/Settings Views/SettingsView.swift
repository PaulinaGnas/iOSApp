//
//  SettingsVIew.swift
//  Grocery List
//
//  Created by Paulina Gnas on 05/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("DarkAppearance") var darkAppearance = false
    
    var body: some View {
        Form {
            Section {
                NavigationLink {
                   BackgroundSettingsView()
                } label: {
                    Text("Background theme")
                }
                
                Toggle("Dark Appearance", isOn: $darkAppearance)

            } header: {
                Text("Theme settings")
            }
            
            Section {
                ForEach(formStaticData) { row in
                    FormStaticRowView(staticRow: row)
                }
            } header: {
                Text("About the application")
            }
        }
    }
}

struct SettingsVIew_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
