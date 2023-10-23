//
//  CDNoteItem+CoreDataProperties.swift
//  CalNotes
//
//  Created by Jacky Lam on 2023-10-23.
//
//

import Foundation
import CoreData


extension CDNoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNoteItem> {
        return NSFetchRequest<CDNoteItem>(entityName: "CDNoteItem")
    }

    @NSManaged public var amount: Float
    @NSManaged public var category: Int16
    @NSManaged public var id: Int16
    @NSManaged public var image: Data?
    @NSManaged public var noteId: Int16
    @NSManaged public var remarks: String?
    @NSManaged public var title: String?

}

extension CDNoteItem : Identifiable {

}
