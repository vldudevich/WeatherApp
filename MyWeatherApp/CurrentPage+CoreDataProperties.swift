//
//  CurrentPage+CoreDataProperties.swift
//  
//
//  Created by vladislav on 28.08.2020.
//
//

import Foundation
import CoreData


extension CurrentPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentPage> {
        return NSFetchRequest<CurrentPage>(entityName: "CurrentPage")
    }

    @NSManaged public var index: Int64

}
