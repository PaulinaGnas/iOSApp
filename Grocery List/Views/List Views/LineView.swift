//
//  LineView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 09/05/2023.
//

import SwiftUI

struct LineView: View {
    @ObservedObject var list: ShopList
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: ListDetailView(filter: list.unwrappedName, listFilter: list.unwrappedName)) {
                HStack {
                    Text(list.unwrappedName)
                    Spacer()
                    VStack {
                        Text("Bought")
                            .font(.system(size: 10))
                        Text("\(list.unwrappedCheckProducs)/\(list.producsArray.count)")
                            .font(.system(size: 15))
                    }
                    .foregroundColor(.gray)
                }
            }
            .frame(width: 0, height: 0)
            .hidden()
        }
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(list: ShopList())
    }
}
