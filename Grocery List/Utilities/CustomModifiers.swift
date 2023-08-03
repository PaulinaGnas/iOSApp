//
//  CustomModifiers.swift
//  Grocery List
//
//  Created by Paulina Gnas on 05/06/2023.
//

import Foundation
import SwiftUI

struct TitleModifier: ViewModifier {
    @FetchRequest(sortDescriptors: []) private var theme: FetchedResults<Theme>
    
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .serif))
            .fontWeight(.bold)
            .padding(8)
            .foregroundColor(Color(UIColor(named: theme.first?.topColor ?? "purple8")!))
    }
}

struct SquareButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold, design: .default))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
            .foregroundColor(.white)
            .background {
                BackgroundButtonView()
            }
            .cornerRadius(9)
    }
}

struct RoundedBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(UIColor(named: "BackgroundColor")!))
            .cornerRadius(12)
            .shadow(color: Color.gray, radius: 8, x: 0, y: 0)
    }
}
