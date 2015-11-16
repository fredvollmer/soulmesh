//
//  FloorMap+CoreDataProperties.swift
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

extension FloorMap {

    @NSManaged var buildingID: NSNumber?
    @NSManaged var floorMapID: NSNumber?
    @NSManaged var floorNumber: NSNumber?
    @NSManaged var svg: String?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var installedSesnors: NSSet?

}
