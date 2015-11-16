//
//  vc_floorMap.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/8/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import MagicalRecord

class vc_floorMap: UIViewController, UIScrollViewDelegate {

    // MARK: Properties
    var floor: FloorMap = FloorMap()
    
    @IBOutlet weak var view_svg: smSVG!
    @IBOutlet weak var floorScroller: UIScrollView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Initial stylings
        floorScroller.delegate = self
        floorScroller.backgroundColor = UIColor.clearColor()
        view_svg.backgroundColor = UIColor.clearColor()
            
        let floor = FloorMap.MR_createEntity()
            
        }
    
    func displayFloor(floor: FloorMap) {
        self.floor = floor
        setFloorScrollerImage(floor.getSVG())
        
    }
    
        func getLayers(sublayers :[AnyObject]) -> [CAShapeLayer]{
            var ShapArray : [CAShapeLayer] = []
            for eachLayer in sublayers{
                if let newLayer = eachLayer as? CAShapeLayer{
                    ShapArray.append(newLayer)
                }
                if let newLayer = eachLayer as? CALayer, sub = newLayer.sublayers {
                    ShapArray = ShapArray + (getLayers(sub))
                }
            }
            return ShapArray
        }
        
        func centerScrollViewContents(imgView: SVGKLayeredImageView) {
            let boundsSize = floorScroller.bounds.size
            var contentsFrame = imgView.frame
            
            if contentsFrame.size.width < boundsSize.width {
                contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
            } else {
                contentsFrame.origin.x = 0.0
            }
            
            if contentsFrame.size.height < boundsSize.height {
                contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
            } else {
                contentsFrame.origin.y = 0.0
            }
            
            imgView.frame = contentsFrame
        }
    
    func setFloorScrollerImage(svgimg: SVGKImage) {
        
        // Setup framing for this new image
        svgimg.size = floorScroller.bounds.size
        view_svg.image = svgimg
        floorScroller.contentSize = svgimg.size
        
        // Compute minimum zoom scale
        let scrollViewFrame = self.floorScroller.frame
        let scaleWidth = scrollViewFrame.size.width / self.floorScroller.contentSize.width;
        let scaleHeight = scrollViewFrame.size.height / self.floorScroller.contentSize.height;
        let minScale = min(scaleWidth, scaleHeight);
        
        self.floorScroller.minimumZoomScale = minScale;
        self.floorScroller.maximumZoomScale = 4.0;
        self.floorScroller.zoomScale = minScale;
        
        centerScrollViewContents(view_svg)

    }
        
        // Scroll shit
        func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
            return view_svg
        }
        
        func scrollViewDidZoom(scrollView: UIScrollView) {
            centerScrollViewContents(view_svg)
            view_svg.scaleSensors(floorScroller.zoomScale, minScale: floorScroller.minimumZoomScale)
        }
        
        // MARK: Utility functions
        func changeFillColorRecursively(sublayers: [AnyObject], color: UIColor) {
            for layer in sublayers {
                if let l = layer as? CAShapeLayer {
                    l.fillColor = color.CGColor
                }
                if let l = layer as? CALayer, sub = l.sublayers {
                    changeFillColorRecursively(sub, color: color)
                }
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    // MARK: Sensor MArkers
    
    func updateSensorsWithFloor (floor: FloorMap) {
        // Clear previous floor's sensors
        for mark in view_svg.subviews {
            if (mark.isKindOfClass(view_sensorMark)) {
                mark.removeFromSuperview()
            }
        }
        
        for sensorObject in floor.installedSesnors! {
            let sensor = sensorObject as! InstalledSesnor
            // Create marker view
            let mark : view_sensorMark = view_sensorMark()
            mark.frame = CGRectMake(0, 0, 50, 50)
            mark.center = CGPointMake(CGFloat(sensor.x!), CGFloat(sensor.y!))
            mark.backgroundColor = UIColor.clearColor()
            
            // Link with sensor object
            mark.sensor = sensor
            
            // "Drag" gesture recognizer
            let gr : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didDragSensor:")
            mark.addGestureRecognizer(gr)
            
            self.view_svg.addSubview(mark)
        }
    }
    
    func didDragSensor(recognizer : UIPanGestureRecognizer) {
        // Get this sensor's view
        let sensor : view_sensorMark = recognizer.view as! view_sensorMark
        // Get the amount this gesture will move view
        let delta = recognizer.translationInView(self.view_svg)
        // Calculate the new frame after move
        var newSensorFrame = sensor.frame
        newSensorFrame.origin.x += delta.x
        newSensorFrame.origin.y += delta.y
        
        // Only move if the new frame would lie on the floor plan
        if (CGRectContainsRect(self.view.frame, newSensorFrame)) {
            sensor.frame = newSensorFrame
        }
        
        // Must set translation back to 0
        recognizer.setTranslation(CGPointZero, inView: self.view_svg)
    }
    
    
    
        /*
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
        */
        
}
