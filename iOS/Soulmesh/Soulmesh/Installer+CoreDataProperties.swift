//
//  Installer+CoreDataProperties.swift
//  Soulmesh
//
//  Created by Annie Fischer on 11/26/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Installer {

    @NSManaged var buildingID: NSNumber?
    @NSManaged var guid: String?
    @NSManaged var name: String?
    @NSManaged var syncStatus: NSNumber?
    @NSManaged var building: Building?

}
