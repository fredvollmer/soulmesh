//
//  SoulmeshAPI.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import SwiftyJSON

class SoulmeshAPI: NSObject {
    
    // MARK: Properties
    var server : ServerInterface
    var pm : PersistencyManager
    var online : Bool
    
    // Init
    override init() {
        server = ServerInterface()
        pm = PersistencyManager()
        online = false
        super.init()
    }
    
    // Singleton creation
    class var sharedInstance: SoulmeshAPI {
        struct Singleton {
            static let instance = SoulmeshAPI();
        }
        return Singleton.instance;
    }
    
    // Response processor
    
    
    /**************** Building ****************/
    
    // Get one building
    func getBuildingById (buildingID: Int)  {
        //return server.getBuildingByID(buildingID)
    }

}
