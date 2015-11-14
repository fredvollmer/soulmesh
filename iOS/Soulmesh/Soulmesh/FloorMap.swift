//
//  FloorMap.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/10/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import SwiftyJSON

class FloorMap: NSObject {
    
    // MARK: Properties
    var buildingID : Int = 0
    var floorNumber : Int = 0
    var id : Int? = 0
    var svg : SVGKImage = SVGKImage()
    var sensors : [Sensor] = [Sensor]()
    let api : SoulmeshAPI = SoulmeshAPI.sharedInstance
    
    init(building : Int, floor: Int) {
        buildingID = building
        floorNumber = floor
        super.init()
    }
    
    func load(callback: Void -> ()) {
        // Load floor SVG asynchronously
        let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/8/84/Example.svg")
        self.svg = SVGKImage(contentsOfURL: url)
        api.getFloorMap(buildingID, floor: floorNumber, callback: {json in
            self.id = Int(json["floorMapID"]!.string!)
            print(String(json["floorPlan"]))
            callback()
        })
    }
}
