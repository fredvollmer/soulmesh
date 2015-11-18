//
//  SMSyncEngine.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/14/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import CoreData
import AFNetworking

class SMSyncEngine: NSObject {
    
    // MARK: Properties
    var registeredClassesToSync: [String] = Array()
    
    // Singleton creation
    class var sharedInstance: SMSyncEngine {
        struct Singleton {
            static let instance = SMSyncEngine();
        }
        return Singleton.instance;
    }
    
    // Register a class to sync
    func registerNSManagedObjectClassToSync (aClass: AnyClass) {
        if (aClass.isSubclassOfClass(NSManagedObject)) {
            let nameSpaceClassName = NSStringFromClass(aClass.self)
            let className = nameSpaceClassName.componentsSeparatedByString(".").last! as String
            registeredClassesToSync.append(className)
        } else {
            NSLog("Unable to register a class as it is already registered")
        }
        
    }
    
    
    // Return most recent time a given entity was updated
    func mostRecentUpdatedAtDateForEntityWithName (name: String) -> NSDate {
        
        var date: NSDate = NSDate(timeIntervalSince1970: 0)
        
        // Create NSFetchRequest
        let request = NSFetchRequest(entityName: name)
        
        // Setup sorting by updatedAt in descending order
        request.sortDescriptors = [ NSSortDescriptor(key: "updatedAt", ascending: false) ]
        
        // Set limit to 1
        request.fetchLimit = 1
        
        // Get context for background use
        let context = NSManagedObjectContext.MR_context()
        context.performBlockAndWait({
            //var error: NSError
            let results: [AnyObject]
            do {
                results = try context.executeFetchRequest(request)
            } catch {
                NSLog("Error with fetch.")
                results = []
            }
            if ((results.last) != nil) {
                // Set date to the fetched result
                date = results.last?.valueForKey("updatedAt") as! NSDate
                
            } else {
                date = NSDate(timeIntervalSince1970: 0)
            }
        })
        // Finally, we can return a damn date!
        return date
    }
    
    // Download data for delta sync
    func downloadDataForRegisteredObjects (useUpdatedAtDate: Bool) {
        var operations: [AFHTTPRequestOperation] = []
        
        // Loop through all registered class
        for className: String in registeredClassesToSync {
            var mostRecentUpdateDate: NSDate? = nil
            if (useUpdatedAtDate) {
                mostRecentUpdateDate = mostRecentUpdatedAtDateForEntityWithName(className)
            }
            
            // Create request
            let request: NSMutableURLRequest = SMAPIClient.sharedInstance.GETRequestForAllRecordsOfClass(className, updatedAfterDate: mostRecentUpdateDate)!
            
            // Create request operation
            let operation: AFHTTPRequestOperation = AFHTTPRequestOperation(request: request)
            
            operation.setCompletionBlockWithSuccess({(operation: AFHTTPRequestOperation, response: AnyObject) in
                NSLog("We'vbe had succes!")
                },
                failure: {(operation: AFHTTPRequestOperation, error: NSError) in
                    NSLog(error.description)
            })
            
            // Add to operations
            operations.append(operation)
            
        }
        
        // Add to operations queue
        SMAPIClient.sharedInstance.operationQueue.addOperations(operations, waitUntilFinished: true)
    }
    
}


