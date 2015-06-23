//
//  CenterViewController.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/12/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit

class InstrumentViewController: UIViewController, CsoundObjListener {
    
    let diatonicKeyboard = DiatonicKeyboardView(frame: CGRectZero)
    
    let csound = CsoundObj()

    let autolayoutMetrics = ["controlPanelHeight":150.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createControlPanel()
        createKeyboard()
        
        csound.addListener(self)
        csound.play(NSBundle.mainBundle().pathForResource("Hidrae", ofType: "csd"))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // At this point, the DiatonicKeyboard can access it's frame
        
        diatonicKeyboard.recreateKeyLabels()
    }
    
    func createControlPanel() {
        
        //
        let menuBar = UIView()
        menuBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        menuBar.backgroundColor = UIColor.whiteColor()
        
        // Create Settings button
        let settingsButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        settingsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        settingsButton.setTitle("Settings", forState: UIControlState.Normal)
        settingsButton.addTarget(self, action: "presentLeftPanel", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Create About button
        let aboutButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        aboutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        aboutButton.setTitle("About", forState: UIControlState.Normal)
        aboutButton.addTarget(self, action: "presentRightPanel", forControlEvents: UIControlEvents.TouchUpInside)
        aboutButton.titleLabel!.textAlignment = NSTextAlignment.Right // for placement on right-hand side
        
        // Create title label
        let titleLabel = UILabel()
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.text = "Diatonic Touch"
        titleLabel.textAlignment = NSTextAlignment.Center
        
        // add the views.
        // self.view & menuBar will retain these subviews;
        // we won't be needing further reference to them after this.
        menuBar.addSubview(settingsButton)
        menuBar.addSubview(aboutButton)
        menuBar.addSubview(titleLabel)
        self.view.addSubview(menuBar)
        

        // Autolayout constraints
        let views = ["menuBar":menuBar, "settingsButton":settingsButton, "aboutButton":aboutButton, "titleLabel":titleLabel]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[menuBar(controlPanelHeight)]", options: NSLayoutFormatOptions(0), metrics: autolayoutMetrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[menuBar]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        menuBar.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[settingsButton(100)]-[titleLabel]-[aboutButton(100)]|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: views))
        menuBar.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[settingsButton]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
    }
    
    func createKeyboard() {
        view.addSubview(diatonicKeyboard)
        let views = ["diatonicKeyboard":diatonicKeyboard]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-controlPanelHeight-[diatonicKeyboard]|", options: NSLayoutFormatOptions(0), metrics: autolayoutMetrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[diatonicKeyboard]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

    }
    
    func presentLeftPanel() {
        NSNotificationCenter.defaultCenter().postNotificationName("showPresetList", object: nil)
    }
    
    func presentRightPanel() {
        NSNotificationCenter.defaultCenter().postNotificationName("showAbout", object: nil)
    }
    
    // MARK: CsoundObjListener
    
    func csoundObjCompleted(csoundObj: CsoundObj!) {
        println("csound complete")
    }
    
    func csoundObjStarted(csoundObj: CsoundObj!) {
        println("csound started")
    }
    
}
