//
//  PresetNavigationViewController.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/24/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit

class PresetNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.frame = CGRectMake(self.view.frame.size.width-rightPanelWidth, 0.0, rightPanelWidth, self.view.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
