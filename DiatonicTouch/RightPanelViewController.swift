//
//  RightPanelViewController.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/12/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit

class RightPanelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRectMake(self.view.frame.size.width-rightPanelWidth, 0.0, rightPanelWidth, self.view.frame.size.height)
        view.backgroundColor = UIColor.blueColor()
    }
    
}
