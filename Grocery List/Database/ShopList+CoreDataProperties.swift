//
//  ShopList+CoreDataProperties.swift
//  Grocery List
//
//  Created by Paulina Gnas on 27/04/2023.
//
//

import Foundation
import CoreData


extension ShopList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShopList> {
        return NSFetchRequest<ShopList>(entityName: "ShopList")
    }

    @NSManaged public var checkProduct: Int16
    @NSManaged public var listName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var products: NSSet?
    
    public var unwrappedName: String {
        listName ?? "Unknown list name"
    }
    public var unwrappedCheckProducs: Int {
        Int(checkProduct)
    }
    public var producsArray: [ShopProduct] {
        let set = products as? Set<ShopProduct> ?? []
        
        return set.sorted {
            $0.completion && !$1.completion
        }
    }
}

// MARK: Generated accessors for products
extension ShopList {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: ShopProduct)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: ShopProduct)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)
}

extension ShopList : Identifiable {

}
