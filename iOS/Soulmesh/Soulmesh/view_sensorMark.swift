//
//  view_sensorMark.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/10/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class view_sensorMark: UIView {
    
    // MARK: Properties
    var sensor: InstalledSensor?
    var highlighted: Bool = false

    override func drawRect(rect: CGRect) {
        // Make bg clear
        backgroundColor = UIColor.clearColor()
        
        // Drawing code
        var color: CGColorRef = UIColor(red: 52/255.0, green: 160/255.0, blue: 166/255.0, alpha: 1.0).CGColor
        
        /*if (highlighted) {
            color = CGColorGetComponents(UIColor(red: 100/255.0, green: 100/255.0, blue: 220/255.0, alpha: 1.0).CGColor)
        } */
        
        let context : CGContextRef? = UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - 14, rect.size.height - 14))
        CGContextSetFillColorWithColor(context, color)
        CGContextSetShadow(context, CGSizeMake(2, 0), 5)
        CGContextFillPath(context)

        // Reset highlight state
        highlighted = false
        
    }

}
