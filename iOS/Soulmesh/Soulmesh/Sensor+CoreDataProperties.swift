//
//  Sensor+CoreDataProperties.swift
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

extension Sensor {

    @NSManaged var buildingID: NSNumber?
    @NSManaged var callibrationDate: NSDate?
    @NSManaged var freeText: String?
    @NSManaged var sensorID: NSNumber?
    @NSManaged var sensorType: String?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var building: Building?

}
