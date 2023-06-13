//
//  UserRecipe+CoreDataProperties.swift
//  Grocery List
//
//  Created by Paulina Gnas on 17/05/2023.
//
//

import Foundation
import CoreData


extension UserRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRecipe> {
        return NSFetchRequest<UserRecipe>(entityName: "UserRecipe")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var recipeName: String?
    @NSManaged public var rating: Int16
    @NSManaged public var instructions: String?
    @NSManaged public var note: String?
    @NSManaged public var preparationTime: Int16
    @NSManaged public var serves: Int16
    @NSManaged public var image: Data?
    @NSManaged public var listOfIngredients: NSSet?
    
    public var unwrappedServes: Int {
        Int(serves)
    }
    
    public var unwrappedRecipeName: String {
        recipeName ?? "Unknown Recipe"
    }
    
    public var unwrappedRating: Int {
        Int(rating)
    }
    
    public var unwrappedInstructions: String {
        instructions ?? "No instructions"
    }
    
    public var unwrappedNote: String {
        note ?? "No notes"
    }
    
    public var unwrappedPreparationTime: Int {
        Int(preparationTime)
    }
    
    public var unwrappedListOfIngredients: [UserIngredient] {
        let set = listOfIngredients as? Set<UserIngredient> ?? []
        return set.sorted {
            $0.unwrappedIngredientName > $1.unwrappedIngredientName
        }
    }
}

// MARK: Generated accessors for listOfIngredients
extension UserRecipe {

    @objc(addListOfIngredientsObject:)
    @NSManaged public func addToListOfIngredients(_ value: UserIngredient)

    @objc(removeListOfIngredientsObject:)
    @NSManaged public func removeFromListOfIngredients(_ value: UserIngredient)

    @objc(addListOfIngredients:)
    @NSManaged public func addToListOfIngredients(_ values: NSSet)

    @objc(removeListOfIngredients:)
    @NSManaged public func removeFromListOfIngredients(_ values: NSSet)

}

extension UserRecipe : Identifiable {

}
