//
//  Theme+CoreDataProperties.swift
//  Grocery List
//
//  Created by Paulina Gnas on 05/06/2023.
//
//

import Foundation
import CoreData
//import UIKit


extension Theme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Theme> {
        return NSFetchRequest<Theme>(entityName: "Theme")
    }

    @NSManaged public var topColor: String?
    @NSManaged public var bottomColor: String?
    
    public var unwrappedTopColor: String {
        return topColor ?? "pink5"
    }
    
    public var unwrappedBottomColor: String {
        return bottomColor ?? "blue3"
    }
}

extension Theme : Identifiable {

}
