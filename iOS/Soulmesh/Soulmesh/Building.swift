//
//  Building.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/4/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import SwiftyJSON

class Building: NSObject {
    
    // MARK: Properties
    var id : Int
    var name : String
    var long : Double
    var lat : Double
    
    // Build Building from JSON
    init (withJson json : JSON) {
        id = json["buildingID"].int!
        name = json["buildingName"].string!
        long = json["buildingLong"].double!
        lat = json["buildingLat"].double!
        super.init()

    }

}
