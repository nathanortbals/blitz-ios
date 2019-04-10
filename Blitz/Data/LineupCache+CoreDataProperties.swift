//
//  LineupCache+CoreDataProperties.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//
//

import Foundation
import CoreData


extension LineupCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LineupCache> {
        return NSFetchRequest<LineupCache>(entityName: "LineupCache")
    }

    @NSManaged public var d: String?
    @NSManaged public var f: String?
    @NSManaged public var qb: String?
    @NSManaged public var rb1: String?
    @NSManaged public var rb2: String?
    @NSManaged public var te: String?
    @NSManaged public var wr1: String?
    @NSManaged public var wr2: String?
    @NSManaged public var wr3: String?
    @NSManaged public var date: NSDate?

}
