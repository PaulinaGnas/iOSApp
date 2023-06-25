//
//  ShopProduct+CoreDataProperties.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//
//

import Foundation
import CoreData

extension ShopProduct {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShopProduct> {
        return NSFetchRequest<ShopProduct>(entityName: "ShopProduct")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var amount: String?
    @NSManaged public var image: String?
    @NSManaged public var choosenUnit: String?
    @NSManaged public var completion: Bool
    @NSManaged public var originList: ShopList?
    
    public var unwrappedName: String {
        name ?? "Unknown product"
    }
    public var unwrappedAmount: String {
        amount ?? "Unknown"
    }
    public var unwrappedImage: String {
        image ?? "basket"
    }
    public var unwrappedUnit: String {
        choosenUnit ?? "Unknown"
    }
}

extension ShopProduct : Identifiable {

}
