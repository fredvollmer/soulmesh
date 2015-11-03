//
//  ViewController.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import MMMaterialDesignSpinner

class vc_login: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var button_login: UIButton!
    
    @IBOutlet weak var table_buildings: UITableView!
    
    // Login view chain
    var login_form : UIView!
    var login_AI: UIView!
    var login_welcome : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial UI styling adjustments
        button_login.layer.cornerRadius = 7
        
        // Grab views for login sequence
        login_form = self.view.viewWithTag(1)
        login_AI = self.view.viewWithTag(2)
        login_welcome = self.view.viewWithTag(3)
        
        // Add spinner to AI view
        let spinner = MMMaterialDesignSpinner(frame: CGRectMake(0,0,60,60))
        spinner.lineWidth = 4
        spinner.tintColor = UIColor(red: 211/255.0, green: 147/255.0, blue: 44/255.0, alpha: 1.0)
        spinner.frame.origin = login_AI.bounds.origin
        login_AI.addSubview(spinner)
        spinner.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segues
    
    @IBAction func login_main(sender: AnyObject) {
        // Hide form, show AI
        UIView.transitionFromView(
            login_form, toView: login_AI, duration: 0.4, options: [.ShowHideTransitionViews, .TransitionCrossDissolve], completion: nil)
        
        
        //performSegueWithIdentifier("login-main", sender: sender)
    }

}

