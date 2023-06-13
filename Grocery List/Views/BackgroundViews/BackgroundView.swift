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
        LinearGradient(gradient: Gradient(colors: [Color(uiColor: theme.first?.topColor ?? .purple), Color(uiColor: theme.first?.bottomColor ?? .red)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
