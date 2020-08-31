//
//  City+CoreDataProperties.swift
//  
//
//  Created by vladislav on 31.08.2020.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?

}
