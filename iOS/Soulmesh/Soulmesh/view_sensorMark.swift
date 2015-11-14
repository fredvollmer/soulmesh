//
//  view_sensorMark.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/10/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class view_sensorMark: UIView {

    override func drawRect(rect: CGRect) {
        // Drawing code
        let context : CGContextRef? = UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(context, rect)
        CGContextSetFillColor(context, CGColorGetComponents(UIColor(red: 52/255.0, green: 160/255.0, blue: 166/255.0, alpha: 1.0).CGColor))
        CGContextSetShadow(context, CGSizeMake(2, 0), 5)
        CGContextFillPath(context)
    }

}
