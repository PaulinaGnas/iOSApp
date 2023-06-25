//
//  ColorsView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 16/06/2023.
//

import SwiftUI

struct ColorsView : View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(.red)
                    .frame(width: 15, height: 15)
                    .cornerRadius(5)
                    .padding(0)
                
                Rectangle()
                    .fill(.yellow)
                    .frame(width: 15, height: 15)
                    .cornerRadius(5)
                    .padding(0)
            }
            .padding(0)
            
            HStack {
                Rectangle()
                    .fill(.orange)
                    .frame(width: 15, height: 15)
                    .cornerRadius(5)
                    .padding(0)
                
                Rectangle()
                    .fill(.green)
                    .frame(width: 15, height: 15)
                    .cornerRadius(5)
                    .padding(0)
            }
            .padding(0)
        }
        .padding(5)
    }
}

struct ColorsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorsView()
    }
}
