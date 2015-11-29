//
//  sensorAddButtonViewController.swift
//  Soulmesh
//
//  Created by Tyler Wright on 11/20/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class sensorAddButtonViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate    //get appDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.text = appDelegate.barcodeIn //set text field to appDelegate.barcodeIn value
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
