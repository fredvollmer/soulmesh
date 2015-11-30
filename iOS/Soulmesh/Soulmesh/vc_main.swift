//
//  vc_main.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/20/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import MagicalRecord

class vc_main: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    var building: Building?
    
    @IBOutlet weak var btn_floors: UIButton!;
    @IBOutlet weak var btn_back: UIButton!;
    @IBOutlet weak var btn_add: UIButton!;
    @IBOutlet weak var btn_sensors: UIButton!;
    @IBOutlet weak var view_floorContainer: UIView!
    @IBOutlet weak var constraint_sensorTableWidth: NSLayoutConstraint!
    @IBOutlet weak var table_sensors: UITableView!
    
    var floorVC : vc_floorMap = vc_floorMap()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load initial building
        building = Building.MR_findFirstByAttribute("guid", withValue: 7)
        
        // Set additional style properties
        btn_floors.setTitle("\u{f0cb}", forState: .Normal)
        btn_back.setTitle("\u{f053}", forState: .Normal)
        btn_add.setTitle("\u{f067}", forState: .Normal)
        btn_sensors.setTitle("\u{f041}", forState: .Normal)
        
        // Sensor table setup
        table_sensors.delegate = self
        table_sensors.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.addChildViewController(floorVC)
        floorVC.view.frame = view_floorContainer.bounds
        self.view_floorContainer.addSubview(floorVC.view)
        
        // Set initial floor
        if (building != nil && building?.sortedFloorsArray.count > 0) {
            floorVC.displayFloor( (building?.sortedFloorsArray.first)! )
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Switch to a new floor
    func didSelectNewFloor(floor: FloorMap) {
        
    }
    
    // MARK: Table delegate methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let x = (floorVC.floor?.installedSesnors?.count) {
            return x
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let floor: InstalledSensor = floorVC.floor?.installedSesnors![indexPath.row] as! InstalledSensor
        let cell : UITableViewCell =  tableView.dequeueReusableCellWithIdentifier("sensorCell") as UITableViewCell!
        cell.textLabel?.text = floor.guid
        cell.detailTextLabel?.text = floor.freeText
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {action, indexPath in
            print("Delete!!!!!")
        })
        
        return [deleteAction]
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        floorVC.highlightSensor(withIndex: indexPath.row)
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
            if let controller: vc_table_floors = segue.destinationViewController as? vc_table_floors {
                // Set building
                controller.building = building
                // Align arrow with proper button
                controller.popoverPresentationController!.sourceRect = controller.popoverPresentationController!.sourceView!.bounds
            }
            break
            
        default:
            break
        }
    }
    
    // MARK: Button actions
    @IBAction func showSensors (sender: AnyObject) {
        if (constraint_sensorTableWidth.constant > 0) {
            // Hide
            constraint_sensorTableWidth.constant = 0
        } else {
            // Show
            constraint_sensorTableWidth.constant = 240
        }
        UIView.animateWithDuration(0.5, animations: {
            self.view.layoutIfNeeded()
        })
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
