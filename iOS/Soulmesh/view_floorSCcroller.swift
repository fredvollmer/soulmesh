//
//  view_floorSCcroller.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/6/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class view_floorSCcroller: UIScrollView, UIScrollViewDelegate {
    
    var view_svg: SVGKLayeredImageView!;

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        // Add SVG subview
        view_svg.frame = self.bounds
        self.addSubview(view_svg)
        
        // Load SVG
        let svgimg: SVGKImage = SVGKImage(named: "floor1.svg");
        
        svgimg.size = CGSize(
            width: view_svg.frame.size.width - 20,
            height: view_svg.frame.size.height - 20);
        
        view_svg.backgroundColor = UIColor.clearColor();
        
        
        view_svg.image = svgimg;
        
        //changeFillColorRecursively(view_svg.layer.sublayers!, color: UIColor.grayColor())
        
        view_svg.hidden = false
        
        // Scroll view setup
        self.delegate = self
        
        self.contentSize = svgimg.size;
        
        let scrollViewFrame = self.frame
        let scaleWidth = scrollViewFrame.size.width / self.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / self.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        self.minimumZoomScale = minScale;
        
        self.maximumZoomScale = 4.0
        self.zoomScale = minScale;
        
        centerScrollViewContents(view_svg)
        
        //shapeLayerArray = getLayers(view_svg.layer.sublayers!)

    }
    
    // Scroll shit
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return view_svg
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents(view_svg)
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
        let boundsSize = self.bounds.size
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

}
