//
//  BackgroundButtonView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 05/06/2023.
//

import SwiftUI

struct BackgroundButtonView: View {
    @FetchRequest(sortDescriptors: []) private var theme: FetchedResults<Theme>
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(uiColor: theme.first?.topColor ?? .purple), Color(uiColor: theme.first?.bottomColor ?? .red)]), startPoint: .leading, endPoint: .trailing)
    }
}

struct BackgroundButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundButtonView()
    }
}
