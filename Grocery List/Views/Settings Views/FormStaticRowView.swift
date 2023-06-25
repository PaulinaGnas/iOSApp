//
//  FormStaticRowView.swift
//  Grocery List
//
//  Created by Paulina Gnas on 25/06/2023.
//

import SwiftUI

struct FormStaticRowView: View {
    var staticRow: FormStatic
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundColor(.gray)
                
                Image(systemName: staticRow.image)
                    .foregroundColor(.white)
                    .imageScale(.large)
            }
            .frame(width: 36, height: 36)
            Text(staticRow.firstText)
                .foregroundColor(.gray)
            Spacer()
            Text(staticRow.secondText)
        }
    }
}

struct FormStaticRowView_Previews: PreviewProvider {
    static var previews: some View {
        FormStaticRowView(staticRow: formStaticData[0])
    }
}
