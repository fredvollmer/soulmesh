//
//  table_buildingList.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/25/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class table_buildingList: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var vcDelegate : BuildingTableProtocol? = nil
    
    // MARK: Temporary prototyping vars
    let _buildingList: [String] = ["Reid Hall", "Montana Hall", "EPS"];
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Setup table view with initial programatic styles
    func setup() {
        // Set this class to delegate and data source
        self.delegate = self;
        self.dataSource = self;
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        // Register cell class
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier: "buildListCell")
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
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell =  self.dequeueReusableCellWithIdentifier("buildListCell") as UITableViewCell!
        cell.textLabel?.text = _buildingList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        vcDelegate?.selectBuilding(555)
    }
}
