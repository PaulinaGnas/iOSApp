//
//  FormStatic.swift
//  Grocery List
//
//  Created by Paulina Gnas on 25/06/2023.
//

import Foundation

struct FormStatic: Identifiable {
    let id = UUID()
    let image: String
    let firstText: String
    let secondText: String
}

let formStaticData: [FormStatic] = [
    FormStatic(image: "gear", firstText: "Application", secondText: "Grocery List"),
    FormStatic(image: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad"),
    FormStatic(image: "keyboard", firstText: "Developer", secondText: "Paulina Gnas")
]
