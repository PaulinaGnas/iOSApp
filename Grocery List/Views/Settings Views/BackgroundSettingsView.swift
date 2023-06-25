//
//  BackgroundSettingsView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 14/06/2023.
//

import SwiftUI

struct BackgroundSettingsView: View {
    
    @StateObject private var viewModel = BackgroundSettingsViewModel()
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) var theme: FetchedResults<Theme>
      
    var body: some View {
        ScrollView(.vertical) {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor(named: viewModel.topColor)!), Color(UIColor(named: viewModel.bottomColor)!)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(12)
                .frame(width: 200, height: 200)
            
            HStack {
                Picker("Section", selection: $viewModel.selection) {
                    Text("Top").tag(0)
                    Text("Bottom").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(width: 220)
                .padding()
                .foregroundColor(.black)
                
                Menu {
                    Picker("Pallete", selection: $viewModel.palette) {
                        ForEach(viewModel.palettes, id: \.self) {
                            Text($0)
                        }
                    }
                } label: {
                    HStack {
                        Text("Palettes")
                            .foregroundColor(.black)
                        ColorsView()
                    }
                }
            }
            LazyVGrid(columns: viewModel.gridLayout, spacing: 20) {
                ForEach(viewModel.currentPalette, id: \.self) { color in
                    Rectangle()
                        .cornerRadius(12)
                        .foregroundColor(Color(color))
                        .frame(minWidth: 100, minHeight: 100)
                        .onTapGesture {
                            viewModel.selectSection(color)
                        }
                }
            }
            .padding(.horizontal)
            .navigationTitle(Text("Choose colors"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.saveTheme(theme.first)
                    } label: {
                        Text("Save")
                            .foregroundColor(Color(UIColor(named: "fontColor")!))
                    }
                }
            }
        }
    }
}

struct BackgroundSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundSettingsView()
    }
}
