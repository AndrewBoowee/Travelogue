//
//  Trip+CoreDataProperties.swift
//  Travelogue
//
//  Created by Drew Boowee on 7/26/19.
//  Copyright © 2019 Drew Boowee. All rights reserved.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var name: String?
    @NSManaged public var entries: Entry?

}

extension Trip {
    
    @objc(addEntriesObject:)
    @NSManaged public func addToEntries(_ value: Entry)
    
    @objc(removeEntriesObject:)
    @NSManaged public func removeFromEntries(_ value: Entry)
    
    @objc(addEntries:)
    @NSManaged public func addToEntries(_ values: NSSet)
    
    @objc(removeEntries:)
    @NSManaged public func removeFromEntries(_ values: NSSet)
    
}
