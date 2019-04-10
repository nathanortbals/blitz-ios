//
//  LineupCache+CoreDataClass.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class LineupCache: NSManagedObject {
    convenience init?(date: Date?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.init(entity: LineupCache.entity(), insertInto: managedContext)
        
        self.date = date as NSDate?
    }
    
    static func getTodaysLineup() -> LineupCache? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LineupCache> = NSFetchRequest(entityName: "LineupCache")
        fetchRequest.predicate = NSPredicate(format: "date >= %@", startOfDay as NSDate)
        
        do {
            let data = try managedContext.fetch(fetchRequest)
            
            if(data.count > 0) {
                return data[0]
            }
            else {
                let lineupCache = LineupCache(date: Date())
                try lineupCache?.managedObjectContext?.save()
                
                return lineupCache
            }
        } catch {
            print("Could not create or fetch lineup choice from core data")
            return nil
        }
    }
}
