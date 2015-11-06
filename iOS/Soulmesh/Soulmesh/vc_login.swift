//
//  ViewController.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import MMMaterialDesignSpinner

class vc_login: UIViewController, BuildingTableProtocol {
    
    // MARK: Properties
    @IBOutlet weak var button_login: UIButton!
    
    @IBOutlet weak var table_buildings: table_buildingList!
    
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
        
        // Set vcDelegate for building table
        table_buildings.vcDelegate = self;
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
        
        // User login request
        // TODO: Connect to user model
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3*NSEC_PER_SEC)), dispatch_get_main_queue(), {
            // Show welcome/buildings list
            self.view.bringSubviewToFront(self.login_welcome)
            UIView.transitionFromView(
                self.login_AI, toView: self.login_welcome, duration: 0.4, options: [.ShowHideTransitionViews, .TransitionCrossDissolve], completion: nil)
        })
        
        //performSegueWithIdentifier("login-main", sender: sender)
    }
    
    //MARK: SegueFromTable protocol implementation
    func selectBuilding(buildingID: Int) {
        performSegueWithIdentifier("login_main", sender: self)
    }

}

