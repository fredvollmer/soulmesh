//
//  vc_sensorDetailViewController.swift
//  Soulmesh
//
//  Created by Annie Fischer on 11/28/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import MagicalRecord

class vc_sensorDetailViewController: UIViewController {
    
    @IBOutlet weak var field_note: UITextField!
    @IBOutlet weak var label_title: UILabel!
    
    var sensor: InstalledSensor?
    var marker: view_sensorMark?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title and text field
        field_note.text = sensor?.freeText
        label_title.text = sensor?.guid
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func deleteInstalledSensor () {
        
        // Delete InstalledSensor entity
        MagicalRecord.saveWithBlock({ context in
            self.sensor?.MR_deleteEntity()
        })
        
        // Remove marker
        if (marker != nil) {
            marker?.removeFromSuperview()
        }
        
        // Dismiss popover
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveText() {
        let textValue = field_note.text
        
        MagicalRecord.saveWithBlock({ context in
            self.sensor?.freeText = textValue
        })
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
