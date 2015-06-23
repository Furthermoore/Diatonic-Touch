//
//  ValueIndicator.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/23/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit

class ValueIndicator: NSObject {
   
    static let sharedInstance = ValueIndicator()
    let indicatorLabel = UILabel()
    
    override init() {
        super.init()
        indicatorLabel.layer.cornerRadius = 50.0
        indicatorLabel.backgroundColor = UIColor.blackColor()
        indicatorLabel.text = "100.0"
        indicatorLabel.textAlignment = NSTextAlignment.Center
        indicatorLabel.font = UIFont.systemFontOfSize(75.0)
        indicatorLabel.textColor = UIColor.whiteColor()
        indicatorLabel.clipsToBounds = true
        indicatorLabel.alpha = 0.0
    }
    
    func fadeInLabel() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.indicatorLabel.alpha = 1.0
        })
    }
    
    func fadeOutLabel() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.indicatorLabel.alpha = 0.0
        })
    }
    
}
