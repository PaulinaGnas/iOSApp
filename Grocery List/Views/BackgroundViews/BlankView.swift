//
//  BlankView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(.black)
        .opacity(0.5)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView()
    }
}
