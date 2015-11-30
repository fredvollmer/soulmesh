//
//  Building.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/14/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Building)
class Building: NSManagedObject {
    
    lazy var sortedFloorsArray: [FloorMap] = {
        var floorArray: [FloorMap] = self.floors?.allObjects as! [FloorMap]
        floorArray.sortInPlace { $0.floorNumber! < $1.floorNumber! }
        return floorArray
    } ()

}
