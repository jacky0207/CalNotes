//
//  CDNote+CoreDataProperties.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-21.
//
//

import Foundation
import CoreData


extension CDNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNote> {
        return NSFetchRequest<CDNote>(entityName: "CDNote")
    }

    @NSManaged public var id: Int16
    @NSManaged public var lastUpdate: String
    @NSManaged public var title: String

}

extension CDNote : Identifiable {

}
