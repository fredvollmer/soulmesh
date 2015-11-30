//
//  SMAPIClient.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import AFNetworking

class SMAPIClient: AFHTTPRequestOperationManager {
    
    //MARK: Properties
    static let baseURLString = "http://dfgt.com.temp.omnis.com/"
    
    // Singleton creation
    static let sharedInstance = SMAPIClient(baseURL: NSURL(string: baseURLString));
    
    // Custom init
    override init(baseURL url: NSURL?) {
        super.init(baseURL: url)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // GET Methods
    func GETRequestForClass (className: String, parameters: NSDictionary)  -> NSMutableURLRequest {
        let request = AFHTTPRequestSerializer.init().requestWithMethod("GET", URLString: (baseURL?.absoluteString)! + className + "/", parameters: parameters)
        return request
    }
    
    func GETRequestForAllRecordsOfClass (className: String, updatedAfterDate updatedDate: NSDate? ) -> NSMutableURLRequest? {
        var request: NSMutableURLRequest
        var parameters: NSDictionary
        
        if ((updatedDate) != nil) {
            //let dateFormatter = NSDateFormatter()
            //dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
            //dateFormatter.timeZone = NSTimeZone(name: "GMT")
            
            parameters = NSDictionary(object: updatedDate!.timeIntervalSince1970, forKey: "updatedAfter")
            
            request = GETRequestForClass(className, parameters: parameters)
            
            return request
        }
        return nil
    }
    

    
}
