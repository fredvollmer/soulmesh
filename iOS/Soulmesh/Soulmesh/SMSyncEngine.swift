//
//  SMSyncEngine.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/14/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import CoreData

class SMSyncEngine: NSObject {
    
    // MARK: Properties
    var registeredClassesToSync: [AnyClass] = Array()
    
    
    // Singleton creation
    class var sharedEngine: SMSyncEngine {
        struct Singleton {
            static let instance = SMSyncEngine();
        }
        return Singleton.instance;
    }
    
    // Register a class to sync
    func registerNSManagedObjectClassToSync (aClass: AnyClass) {
        if (aClass.isSubclassOfClass(NSManagedObject)) {
            registeredClassesToSync.append(aClass.classNameForClass(<#T##NSKeyedArchiver#>))
        }
    }
}
