//
//  UserIngredient+CoreDataProperties.swift
//  Grocery List
//
//  Created by Paulina Gnas on 17/05/2023.
//
//

import Foundation
import CoreData


extension UserIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserIngredient> {
        return NSFetchRequest<UserIngredient>(entityName: "UserIngredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var quantity: String?
    @NSManaged public var unit: String?
    @NSManaged public var image: String?
    @NSManaged public var parentRecipe: UserRecipe?
    
    public var unwrappedIngredientName: String {
        name ?? "Unknown Ingredient"
    }
    
    public var unwrappedQuantity: String {
        quantity ?? "Unknown"
    }
    
    public var unwrappedUnit: String {
        unit ?? "Unknown"
    }
    
    public var unwrappedImage: String {
        image ?? "cart"
    }
}

extension UserIngredient : Identifiable {

}
