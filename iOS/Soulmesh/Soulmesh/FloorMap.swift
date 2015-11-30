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
        let dirPath = SVGCacheDirectory()
        let filePath = NSURL(fileURLWithPath: String(guid), relativeToURL: dirPath)
        let fm = NSFileManager.defaultManager()
        /*if (fm.fileExistsAtPath(filePath.path!)) {
            let image = SVGKImage(contentsOfFile: filePath.path!)
            return image
        } else { */
            // Save image to disk
            do {
                try svg?.writeToFile(filePath.path!, atomically: true, encoding: NSUTF8StringEncoding)
            } catch {
                print("Error saving SVG to disk")
            }
        
        let image = SVGKImage(contentsOfFile: filePath.path!)
        return image
    }
    
    // Get url for json records, creating directory if needed
    func SVGCacheDirectory() -> NSURL {
        let fm = NSFileManager.defaultManager()
        let url: NSURL = NSURL(fileURLWithPath: "TempSVG/", relativeToURL: applicationCacheDirectory() )
        
        if (!fm.fileExistsAtPath(url.path!)) {
            do {
                try fm.createDirectoryAtPath(url.path!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Unable to create SVG cache directory")
            }
        }
        return url
    }
    
    // Get url for cahce
    func applicationCacheDirectory() -> NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
    }

}
