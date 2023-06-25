//
//  BackgroundView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 05/06/2023.
//

import SwiftUI

struct BackgroundView: View {
    @FetchRequest(sortDescriptors: []) private var theme: FetchedResults<Theme>
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(UIColor(named: theme.first?.topColor ?? "purple8")!), Color(UIColor(named: theme.first?.bottomColor ?? "orange7")!)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
