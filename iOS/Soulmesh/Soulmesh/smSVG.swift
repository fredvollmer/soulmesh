//
//  smSVG.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/12/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import CoreGraphics

class smSVG: SVGKLayeredImageView {
    
    override var transform: CGAffineTransform {
        didSet {
            let invertedTransform: CGAffineTransform  = CGAffineTransformInvert(transform);
            for view in subviews {
                view.transform = invertedTransform
            }
        }
    }
    
    // Override setTransform() so that sensors are to remain same size with zoom
    func scaleSensors(zoomScale: CGFloat, minScale: CGFloat) {
        for sensor in subviews {
            if (sensor.isKindOfClass(view_sensorMark)) {
                let delta: CGFloat = (zoomScale - minScale)
                sensor.transform = CGAffineTransformMakeScale(1 - delta, 1 - delta)
            }
        }
    }
}
