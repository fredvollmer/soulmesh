//
//  InstalledSesnor+CoreDataProperties.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension InstalledSesnor {

    @NSManaged var floorMapID: NSNumber?
    @NSManaged var sesnorID: NSNumber?
    @NSManaged var x: NSNumber?
    @NSManaged var y: NSNumber?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var floorMap: FloorMap?
    @NSManaged var sesnor: Sensor?

}
