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
import MagicalRecord

class SMSyncEngine: NSObject {
    
    // MARK: Properties
    var registeredClassesToSync: [NSManagedObject.Type] = Array()
    let context = NSManagedObjectContext.MR_context()
    var syncInProgress: Bool = false
    
    var dateFormatter: NSDateFormatter {
        struct Singelton {
            static let formatter = NSDateFormatter()
        }
        return Singelton.formatter
    }
    
    // Define struct to track sync status
    enum SyncStatus: Int {
        case SMObjectSynced = 0
        case SMObjectCreated = 1
        case SMObjectDeleted = 2
    }
    
    // Singleton creation
    class var sharedInstance: SMSyncEngine {
        struct Singleton {
            static let instance = SMSyncEngine();
        }
        return Singleton.instance;
    }
    
    // Setup date formatter
    func setupDateFormatter() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "GMT")
    }
    
    // Get a date from string returned by API
    func dateFromString (dateString: String) -> NSDate {
        setupDateFormatter()
        return dateFormatter.dateFromString(dateString)!
    }
    
    // Register a class to sync
    func registerNSManagedObjectClassToSync <T: NSManagedObject> (aClass: T.Type) {
        //let nameSpaceClassName =  NSStringFromClass(aClass.self)
        //let className = nameSpaceClassName.componentsSeparatedByString(".").last! as String
        registeredClassesToSync.append(aClass)
    }
    
    // Determine if initial sync has been completred
    func initialSyncComplete() -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey("kSMInitialSyncCompleted")
    }
    
    // Set initial sync completed
    func setInitialSyncCompleted() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "kSMInitialSyncCompleted")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Return most recent time a given entity was updated
    func mostRecentUpdatedAtDateForEntity<T: NSManagedObject> (aClass: T.Type) -> NSDate {
        
        var date: NSDate = NSDate(timeIntervalSince1970: 0)
        
        if let obj: NSManagedObject = aClass.MR_findFirstOrderedByAttribute("updatedAt", ascending: false, inContext: context) {
            
            //if (obj != nil) {
            if (obj.valueForKey("updatedAt") != nil) {
                date = obj.valueForKey("updatedAt") as! NSDate
            }
            
            // Create NSFetchRequest
            /*
            let request = NSFetchRequest(entityName: name)
            
            // Setup sorting by updatedAt in descending order
            request.sortDescriptors = [ NSSortDescriptor(key: "updatedAt", ascending: false) ]
            
            // Set limit to 1
            request.fetchLimit = 1
            
            // Get context for background use
            context.performBlockAndWait({
            //var error: NSError
            let results: [AnyObject]
            do {
            results = try self.context.executeFetchRequest(request)
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
            */
            // Finally, we can return a damn date!
        }
        return date
    }
    
    // Create new instance of managed object with values
    func newMAnagedObjectWithClass<T: NSManagedObject>(aClass: T.Type, withRecord record: NSDictionary) {
        let entity: T = aClass.MR_createEntityInContext(context)
        entity.MR_importValuesForKeysWithObject(record)
        let i: SyncStatus = .SMObjectSynced
        (entity as NSManagedObject).setValue(i.rawValue, forKey: "syncStatus")
    }
    
    // Update existing managed object
    func updateManagedObject(managedObject: NSManagedObject, withRecord record: NSDictionary) {
        let localObj: NSManagedObject = managedObject.MR_inContext(context)
        localObj.MR_importValuesForKeysWithObject(record)
        let i: SyncStatus = .SMObjectSynced
        localObj.setValue(i.rawValue, forKey: "syncStatus")
    }
    
    // Update the value for a given of managed object
    func setValueForManagedObject(withKey key: String, value: AnyObject, managedObject: NSManagedObject) {
        // Create date if needed and set accordingly
        if (key == "updatedAfter") {
            let date: NSDate = dateFromString(value as! String)
            managedObject.setValue(date, forKey: key)
            
        } else if (value is NSArray) {
            // Process as array
            let set: NSSet = NSSet(array: value as! [AnyObject])
            managedObject.setValue(set, forKey: key)
            
        } else {
            // We don't know what the hell this is
            managedObject.setValue(value, forKey: key)
        }
    }
    
    // Get the managed objects for a given class by sync status
    func managedObjectsForClass<T: NSManagedObject> (aClass: T.Type, withSyncStatus syncStatus: SyncStatus) -> [AnyObject] {
        let filter: NSPredicate = NSPredicate(format: "syncStatus = %d", syncStatus.rawValue)
        //let request: NSFetchRequest = aClass.MR_requestAllWithPredicate(filter, inContext: context)
        return aClass.MR_findAllWithPredicate(filter, inContext: context)
    }
    
    // Get the managed objects for a given class sorted by key
    func managedObjectsForClassSorted <T: NSManagedObject> (aClass: T.Type, sortedByKey key: String, inArrayofObjects objects: [Int], inTheArray inArray: Bool) -> [AnyObject] {
        
        let predicate: NSPredicate
        var results: [AnyObject] = Array()
        
        // Build predicate
        if (inArray) {
            predicate = NSPredicate(format: "guid IN %@", objects)
        } else {
            predicate = NSPredicate(format: "NOT (guid IN %@)", objects)
        }
        
        // Build fetch
        let request: NSFetchRequest = aClass.MR_requestAllWithPredicate(predicate, inContext: context)
        request.sortDescriptors = [NSSortDescriptor(key: key, ascending: true)]
        
        // Execute
        context.performBlockAndWait({ void -> () in
            results = aClass.MR_executeFetchRequest(request)
        })
        return results
    }
    
    // The grand finale, where we actually process results into JSON
    func processJSONRecordsIntoCoreData () {
        // Iterate over all registered classes
        for aClass in registeredClassesToSync {
            // If this is initial sync then we fetch form disk and create new objects for each record
            /* if (!initialSyncComplete()) {
            let JSONDict: NSDictionary = JSONDictionaryForClass(aClass)
            let records = JSONDict.objectForKey("results") as! [NSDictionary]
            for record: NSDictionary in records {
            newMAnagedObjectWithClass(aClass, withRecord: record)
            }
            } else { */
            // Determine if record is new or has been updated
            // Get downloaded records
            let downloadedRecords: [AnyObject] = JSONDataRecordsForClass(aClass, sortedByKey: "guid")
            if (downloadedRecords.count > 0) {
                // If we have downloaded records, get stored records for same class:
                let storedGUIDS: [Int] = downloadedRecords.map( {
                    (sr) in return Int(((sr as! NSDictionary).valueForKey("guid")) as! String)!
                })
                let storedRecords = managedObjectsForClassSorted(aClass, sortedByKey: "guid", inArrayofObjects: storedGUIDS, inTheArray: true)
                
                // Iterate over downloaded records                
                for record: NSDictionary in downloadedRecords as! [NSDictionary] {
                        
                        // Check for match, update if so
                        let GUIDofDownloaded = record.valueForKey("guid") as! String
                        if let storedObject = aClass.MR_findFirstByAttribute("guid", withValue: GUIDofDownloaded, inContext: context) {
                            updateManagedObject(storedObject, withRecord: record)
                        } else {
                            // This is a new record, so create the new object
                            newMAnagedObjectWithClass(aClass, withRecord: record)
                        }
                    }
                }
                // Delete JSON from cache for this class
                deleteJSONDataRecordsForClass(aClass)
            }
            // Save context
            context.MR_saveToPersistentStoreAndWait()
            
            // Sync complete, clean up
            executeSyncCompletedOperations()
        }
        
        // Download data for delta sync
        func downloadDataForRegisteredObjects (useUpdatedAtDate: Bool) {
            var operations: [AFHTTPRequestOperation] = []
            var syncError: Bool = false
            
            // Create dispatch group to run operation
            //let queue: dispatch_queue_t = dispatch_get_global_queue(0, 0)
            let group: dispatch_group_t = dispatch_group_create()
            
            // Loop through all registered class
            for aClass: NSManagedObject.Type in registeredClassesToSync {
                let className = NSStringFromClass(aClass)
                var mostRecentUpdateDate: NSDate? = nil
                if (useUpdatedAtDate) {
                    mostRecentUpdateDate = mostRecentUpdatedAtDateForEntity(aClass)
                }
                
                // Create request
                let request: NSMutableURLRequest = SMAPIClient.sharedInstance.GETRequestForAllRecordsOfClass(className, updatedAfterDate: mostRecentUpdateDate)!
                
                // Create request operation, entered into group block
                dispatch_group_enter(group)
                let operation: AFHTTPRequestOperation = AFHTTPRequestOperation(request: request)
                
                // Set serializer to JSON
                operation.responseSerializer = AFJSONResponseSerializer()
                
                // Set completion callbacks
                operation.setCompletionBlockWithSuccess({(operation: AFHTTPRequestOperation, response: AnyObject) in
                    NSLog("We'vbe had succes! Writing to file...")
                    // Make sure response came through as dicitionary...
                    if (response.isKindOfClass(NSDictionary)) {
                        //print(response)
                        self.writeJSONResponseToDisk(response as! NSDictionary, className: className)
                    }
                    dispatch_group_leave(group)
                    },
                    failure: {(operation: AFHTTPRequestOperation, error: NSError) in
                        print("You broke it. No API response.")
                        NSLog(error.description)
                        
                        // Set indicator for error
                        syncError = true
                        
                        dispatch_group_leave(group)
                })
                
                // Add to operations
                operations.append(operation)
                
            }
            
            // Add to operations queue
            SMAPIClient.sharedInstance.operationQueue.addOperations(operations, waitUntilFinished: true)
            
            // Blockj thread until operations are complete
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
            
            // Then process results if no error
            print("We made it to notify!")
            if (!syncError) {
                self.processJSONRecordsIntoCoreData()
            } else {
                print("An error ocurred during data download, sync will not be performed.")
            }
        }
        
        // File management
        
        // Get url for cahce
        func applicationCacheDirectory() -> NSURL {
            return NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
        }
        
        // Get url for json records, creating directory if needed
        func JSONDataRecordsDirectory() -> NSURL {
            let fm = NSFileManager.defaultManager()
            let url: NSURL = NSURL(fileURLWithPath: "JSONRecords/", relativeToURL: applicationCacheDirectory() )
            
            if (!fm.fileExistsAtPath(url.path!)) {
                do {
                    try fm.createDirectoryAtPath(url.path!, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Unable to create records cache directory")
                }
            }
            return url
        }
        
        // Write JSON response to cache
        func writeJSONResponseToDisk (response: NSDictionary, className: String) {
            let fileURL: NSURL = NSURL(fileURLWithPath: className, relativeToURL: JSONDataRecordsDirectory() )
            if (!response.writeToFile(fileURL.path!, atomically: true)) {
                NSLog("Error writing JSON response to disk; attempting to remove nulls and NOTtrynig again...")
                
            }
        }
        
        // Delete cached JSON files
        func deleteJSONDataRecordsForClass <T: NSManagedObject> (aClass: T.Type) {
            let className = NSStringFromClass(aClass)
            let url: NSURL? = NSURL(string: className, relativeToURL: JSONDataRecordsDirectory() )
            do {
                try NSFileManager.defaultManager().removeItemAtURL(url!)
            } catch {
                print("Unable to delete JSON for class" + className)
            }
        }
        
        // Retrive JSON from disk for given class
        func JSONDictionaryForClass <T: NSManagedObject> (aClass: T.Type) -> NSDictionary {
            let className = NSStringFromClass(aClass)
            let fileURL: NSURL = NSURL(string: className, relativeToURL: JSONDataRecordsDirectory())!
            return NSDictionary(contentsOfURL: fileURL)!
        }
        
        // Return actual results for a class sorted by given key
        func JSONDataRecordsForClass <T: NSManagedObject> (className: T.Type, sortedByKey key: String) -> [AnyObject] {
            let dict: NSDictionary = JSONDictionaryForClass(className)
            let records = dict.objectForKey("results")
            return records!.sortedArrayUsingDescriptors([NSSortDescriptor(key: key, ascending: true)])
        }
        
        // Start the sync process
        func startSync() {
            if (!syncInProgress) {
                willChangeValueForKey("syncInProgress")
                syncInProgress = true
                didChangeValueForKey("syncInProgress")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                    self.downloadDataForRegisteredObjects(true)
                })
            }
        }
        
        // Sync completed Operations
        func executeSyncCompletedOperations() {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.setInitialSyncCompleted()
                NSNotificationCenter.defaultCenter().postNotificationName("kSDSyncEngineSyncCompletedNotificationName", object: nil)
                self.willChangeValueForKey("syncInProgress")
                self.syncInProgress = false
                self.didChangeValueForKey("syncInProgress")
                
                // Save default/main context
                NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                print("Save completed!")
            })
        }
}


