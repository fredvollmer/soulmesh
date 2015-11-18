//
//  Building+CoreDataProperties.swift
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

extension Building {

    @NSManaged var buildingID: NSNumber?
    @NSManaged var lattitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var floors: NSSet?
    @NSManaged var sesnors: NSSet?

}
