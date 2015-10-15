//
//  ViewController.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var button_login: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial UI styling adjustments
        button_login.layer.cornerRadius = 7;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

