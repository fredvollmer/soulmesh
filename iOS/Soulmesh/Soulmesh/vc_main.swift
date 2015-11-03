//
//  vc_main.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/20/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class vc_main: UIViewController, UIScrollViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var view_svg: SVGKLayeredImageView!;
    
    @IBOutlet weak var btn_floors: UIButton!;
    @IBOutlet weak var btn_back: UIButton!;
    @IBOutlet weak var btn_add: UIButton!;
    @IBOutlet weak var btn_sensors: UIButton!;
    
    @IBOutlet weak var sv_svgScroller: UIScrollView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load SVG
        let svgimg: SVGKImage = SVGKImage(named: "floor1.svg");
        
        svgimg.size = CGSize(
            width: view_svg.frame.size.width - 20,
            height: view_svg.frame.size.height - 20);
        
        view_svg.backgroundColor = UIColor.clearColor();
        
        view_svg.image = svgimg;
        
        // Scroll view setup
        sv_svgScroller.delegate = self
        
        sv_svgScroller.contentSize = svgimg.size;
        
        let scrollViewFrame = sv_svgScroller.frame
        let scaleWidth = scrollViewFrame.size.width / sv_svgScroller.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / sv_svgScroller.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        sv_svgScroller.minimumZoomScale = minScale;
        
        sv_svgScroller.maximumZoomScale = 4.0
        sv_svgScroller.zoomScale = minScale;
        
        centerScrollViewContents(view_svg)
        
        // Do any additional setup after loading the view.
        
        // Set additional style properties
        btn_floors.setTitle("\u{f0cb}", forState: .Normal)
        btn_back.setTitle("\u{f053}", forState: .Normal)
        btn_add.setTitle("\u{f067}", forState: .Normal)
        btn_sensors.setTitle("\u{f041}", forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        changeFillColorRecursively(view_svg.layer.sublayers!, color: UIColor.grayColor())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Scroll shit
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return view_svg
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents(view_svg)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    func centerScrollViewContents(imgView: SVGKLayeredImageView) {
        let boundsSize = sv_svgScroller.bounds.size
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
    
    // MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier) {
        case "popFloors"? :
            if let controller = segue.destinationViewController.popoverPresentationController {
                controller.sourceRect = controller.sourceView!.bounds
            }
            break
        default:
            break
    }
}
    
    
    /*
- (BOOL)isPoint:(CGPoint)p withinDistance:(CGFloat)distance ofPath:(CGPathRef)path
{
CGPathRef hitPath = CGPathCreateCopyByStrokingPath(path, NULL, distance*2, kCGLineCapRound, kCGLineJoinRound, 0);
BOOL isWithinDistance = CGPathContainsPoint(hitPath, NULL, p, false);
CGPathRelease(hitPath);
return isWithinDistance;
}
*/
}
