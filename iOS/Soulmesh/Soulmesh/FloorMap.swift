//
//  FloorMap.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/14/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import Foundation
import CoreData

@objc(FloorMap)
class FloorMap: NSManagedObject {
    
    // MARK: Properties
    let baseURLToSVG = "http://dfgt.com.temp.omnis.com/svg/"
    
    // Load and get SVG for floor map
    func getSVG () -> SVGKImage {
        var path: NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        path = path.stringByAppendingPathComponent("FloorImages")
        path = path.stringByAppendingPathComponent(String(floorMapID))
        let fm = NSFileManager.defaultManager()
        if (fm.fileExistsAtPath(path as String)) {
            let image = SVGKImage(contentsOfFile: String(path))
            return image
        } else {
            // Save image to disk
            do {
                try svg?.writeToFile(path as String, atomically: true, encoding: NSUTF8StringEncoding)
            } catch {
                print("Error saving SVG to disk")
            }
        }
        let image = SVGKImage(contentsOfFile: String(path))
        return image
    }
}
