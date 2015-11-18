//
//  ServerInterface.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/4/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServerInterface: NSObject {
    
    // Define some constants
    let baseURL : String = "http://dfgt.com.temp.omnis.com/"
    
    
    /**************** Building ****************/
     
     // Get one building
    
    func getBuildingByID (buildingID : Int) {
        var json : JSON?
        Alamofire.request(.GET, baseURL + "building/" + String(buildingID)).responseJSON {
            response in
            switch response.result {
            case .Success(let data):
                json = JSON(data)
                //return Building(withJson: json!)
                break
            case .Failure(let e):
                print(e)
                break
            }
        }
        
    }

}
