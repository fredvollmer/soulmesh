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
    
    @IBOutlet weak var btn_floors: UIButton!;
    @IBOutlet weak var btn_back: UIButton!;
    @IBOutlet weak var btn_add: UIButton!;
    @IBOutlet weak var btn_sensors: UIButton!;
    @IBOutlet weak var view_floorContainer: UIView!
    
    let floorVC : vc_floorMap = vc_floorMap()
    
    var shapeLayerArray :  [CAShapeLayer] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Set additional style properties
        btn_floors.setTitle("\u{f0cb}", forState: .Normal)
        btn_back.setTitle("\u{f053}", forState: .Normal)
        btn_add.setTitle("\u{f067}", forState: .Normal)
        btn_sensors.setTitle("\u{f041}", forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.addChildViewController(floorVC)
        floorVC.view.frame = view_floorContainer.bounds
        self.view_floorContainer.addSubview(floorVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
