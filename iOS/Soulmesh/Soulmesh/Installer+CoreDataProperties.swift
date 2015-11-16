//
//  Installer+CoreDataProperties.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/14/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Installer {

    @NSManaged var installerID: NSNumber?
    @NSManaged var buildingID: NSNumber?
    @NSManaged var name: String?
    @NSManaged var building: Building?

}
