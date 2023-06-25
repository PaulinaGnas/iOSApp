//
//  BackgroundSettingsViewModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 16/06/2023.
//

import Foundation
import SwiftUI

class BackgroundSettingsViewModel: ObservableObject {
    private var moc = PersistenceController.shared.container.viewContext
    
    @Published var brownColors = ["brown0", "brown1", "brown2", "brown3", "brown4", "brown5", "brown6", "brown7", "brown8", "brown9", "brown10", "brown11"]
    @Published var redColors = ["red1", "red2", "red3", "red4", "red5", "red6", "red7", "red8", "red9", "red10", "red11", "red12"]
    @Published var orangeColors = ["orange1", "orange2", "orange3", "orange4", "orange5", "orange6", "orange7", "orange8", "orange9", "orange10", "orange11", "orange12"]
    @Published var yellowColors = ["yellow1", "yellow2", "yellow3", "yellow4", "yellow5", "yellow6", "yellow7", "yellow8", "yellow9", "yellow10", "yellow11", "yellow12"]
    @Published var blueColors = ["blue1", "blue2", "blue3", "blue4", "blue5", "blue6", "blue7", "blue8", "blue9", "blue10", "blue11", "blue12"]
    @Published var greenColors = ["green1", "green2", "green3", "green4", "green5", "green6", "green7", "green8", "green9", "green10", "green11", "green12"]
    @Published var purpleColors = ["purple1", "purple2", "purple3", "purple4", "purple5", "purple6", "purple7", "purple8", "purple9", "purple10", "purple11", "purple12"]
    @Published var pinkColors = ["pink1", "pink2", "pink3", "pink4", "pink5", "pink6", "pink7", "pink8", "pink9", "pink10", "pink11", "pink12"]
    @Published var neonColors = ["n1", "n2", "n3", "n4", "n5", "n6", "n7", "n8", "n9", "n10", "n11", "n12"]
    @Published var pastelColors = ["p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10", "p11", "p12"]
    @Published var selection = 0
    
    @Published var gridLayout: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    @Published var palettes = ["Red", "Brown", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink", "Neon", "Pastel"]
    @Published var palette = "brownColors"
    
    @Published var topColor = UserDefaults.standard.string(forKey: "ThemeTopColor") ?? "purple8"
    @Published var bottomColor = UserDefaults.standard.string(forKey: "ThemeBottomColor") ?? "orange7"
    
    var currentPalette: [String] {
        switch palette {
        case "Blue":
            return blueColors
        case "Brown":
            return brownColors
        case "Red":
            return redColors
        case "Orange":
            return orangeColors
        case "Yellow":
            return yellowColors
        case "Green":
            return greenColors
        case "Purple":
            return purpleColors
        case "Pink":
            return pinkColors
        case "Neon":
            return neonColors
        case "Pastel":
            return pastelColors
            
        default:
            return redColors
        }
    }
    
    func saveTheme(_ theme: Theme?) {
       var th = theme
        if th == nil {
            th = Theme(context: moc)
        }
        th?.topColor = topColor
        th?.bottomColor = bottomColor
        
        do {
            try moc.save()
        } catch {
            print("Dupa")
        }
    }
    
    func selectSection(_ color: String) {
        if selection == 0 {
            topColor = color
        } else {
            bottomColor = color
        }
    }
}
