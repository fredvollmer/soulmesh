//
//  table_buildingList.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/25/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class vc_table_floors: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var building: Building = Building()
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Temporary prototyping vars
    let _buildingList: [String] = ["Basement", "First", "Second", "Roof"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell class
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "buildListCell")
        
        // Styling adjustments
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    // MARK: TableView delegate methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return building.floors!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell =  tableView.dequeueReusableCellWithIdentifier("buildListCell") as UITableViewCell!
        cell.backgroundColor = UIColor.clearColor()
        guard let floorNumber = building.sortedFloorsArray[indexPath.row]!.floorNumber else {
            return cell
        }
        cell.textLabel?.text = String(floorNumber)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Get view controller (presenting)
        let vc: vc_main = presentingViewController as! vc_main
        // Get floor object for this row
        let floor = building.sortedFloorsArray[indexPath.row]
        // Switch floor in parent vc
        vc.didSelectNewFloor(floor!)
        // Dismiss popover
        vc.dismissViewControllerAnimated(true, completion: nil)
    }
}
