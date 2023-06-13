//
//  Theme+CoreDataProperties.swift
//  Grocery List
//
//  Created by Paulina Gnas on 05/06/2023.
//
//

import Foundation
import CoreData
import UIKit


extension Theme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Theme> {
        return NSFetchRequest<Theme>(entityName: "Theme")
    }

    @NSManaged public var colorTopAlpha: Float
    @NSManaged public var colorTopRed: Float
    @NSManaged public var colorTopGreen: Float
    @NSManaged public var colorTopBlue: Float
    @NSManaged public var colorBottomAlpha: Float
    @NSManaged public var colorBottomRed: Float
    @NSManaged public var colorBottomGreen: Float
    @NSManaged public var colorBottomBlue: Float
    
    public var topColor: UIColor {
        return UIColor(red: CGFloat(colorTopRed), green: CGFloat(colorTopGreen), blue: CGFloat(colorTopBlue), alpha: CGFloat(colorTopAlpha))
    }
    
    public var bottomColor: UIColor {
        return UIColor(red: CGFloat(colorBottomRed), green: CGFloat(colorBottomGreen), blue: CGFloat(colorBottomBlue), alpha: CGFloat(colorBottomAlpha))
    }
}

extension Theme : Identifiable {

}
