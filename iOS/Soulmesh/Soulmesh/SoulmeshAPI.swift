//
//  SoulmeshAPI.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 10/15/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit

class SoulmeshAPI: NSObject {
    
    class var sharedInstance: SoulmeshAPI {
        struct Singleton {
            static let instance = SoulmeshAPI();
        }
        return Singleton.instance;
    }

}
