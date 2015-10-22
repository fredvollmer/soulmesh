//
//  vc_main.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/20/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class vc_main: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var view_svg: SVGKFastImageView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load SVG
        let svgimg: SVGKImage = SVGKImage(named: "floor1.svg");
        
        let nodes: NodeList = svgimg.DOMDocument.getElementsByTagName("");
        for var i = 0; i < Int(nodes.length); i++ {
            var element: Element = nodes.item(UInt(i));
        }
        
        view_svg.image = svgimg;
        
        // Do any additional setup after loading the view.
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

}
