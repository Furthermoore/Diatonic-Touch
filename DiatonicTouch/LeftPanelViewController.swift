//
//  LeftPanelViewController.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/12/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit

class LeftPanelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRectMake(0.0, 0.0, leftPanelWidth, self.view.frame.size.height)
        view.backgroundColor = UIColor.greenColor()
    }
    
}
