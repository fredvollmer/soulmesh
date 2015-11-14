//
//  SoulmeshAPI.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SoulmeshAPI: NSObject {
    
    // MARK: Properties
    var server : ServerInterface
    var pm : PersistencyManager
    var online : Bool
    let baseURL = "http://dfgt.com.temp.omnis.com/"
    
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
    
    /**************** Floor ****************/
    
    func getFloorMap(building : Int, floor: Int, callback: [String: JSON] -> Void) {
        Alamofire.request(.GET, baseURL + "floor_id/" + String(building) + "/" + String(floor)).responseJSON {
            response in
            switch response.result {
            case .Success(var data):
                data = response.result.value!
                let json = JSON(data).arrayValue[0].dictionaryValue
                callback(json)
                break
            case .Failure(let e):
                print(e)
                break
            }
        }
    }

}
