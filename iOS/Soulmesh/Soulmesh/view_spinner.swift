//
//  view_spinner.swift
//  Soulmesh
//
//  Created by Fred Vollmer on 11/2/15.
//  Copyright © 2015 Fred Vollmer. All rights reserved.
//

import UIKit
import MMMaterialDesignSpinner

class view_spinner: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup () {
        // Add spinner to AI view
        let spinner = MMMaterialDesignSpinner(frame: CGRectMake(0,0,60,60))
        spinner.lineWidth = 4
        spinner.tintColor = UIColor(red: 211/255.0, green: 147/255.0, blue: 44/255.0, alpha: 1.0)
        spinner.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.addSubview(spinner)
        spinner.startAnimating()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
