//
//  ProductsModel.swift
//  Grocery List
//
//  Created by Paulina Gnas on 28/04/2023.
//

import Foundation

struct Category: Codable, Identifiable {
    let id = UUID()
    let section: String
    let products: [SingleProduct]
}

struct SingleProduct: Equatable, Codable, Identifiable {
    let id = UUID()
    let name: String
    let image: String
}
