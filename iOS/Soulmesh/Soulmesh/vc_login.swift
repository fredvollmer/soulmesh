//
//  ViewController.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class vc_login: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var button_login: UIButton!
    
    @IBOutlet weak var table_buildings: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial UI styling adjustments
        button_login.layer.cornerRadius = 7;
        
        // Buildings table initial setup
        //setupBuildingsTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segues
    
    @IBAction func login_main(sender: AnyObject) {
        performSegueWithIdentifier("login-main", sender: sender)
    }

}

