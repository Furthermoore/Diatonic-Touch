//
//  ViewController.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/12/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit
import QuartzCore

let leftPanelWidth:  CGFloat = 300.0
let rightPanelWidth: CGFloat = 300.0

class MainViewController: UIViewController {
    
    // SETUP A CENTER VC WITH 2 SLIDE OUT
    // NAVIGATION VCs ON THE RIGHT AND LEFT.
    
    // 1. Create our center VC (will be the instrument itself)
    let centerVC = InstrumentViewController()
    
    // 2. User may or may not require left and right panels..
    lazy var leftPanelVC:LeftPanelViewController = {
        var leftPanel = LeftPanelViewController()
        leftPanel.diatonicKeyboard = self.centerVC.diatonicKeyboard
        self.view.addSubview(leftPanel.view)
        self.addChildViewController(leftPanel)
        leftPanel.didMoveToParentViewController(self)
        return leftPanel
    }()
    lazy var rightPanelVC:RightPanelViewController = {
        var rightPanel = RightPanelViewController()
        self.view.addSubview(rightPanel.view)
        self.addChildViewController(rightPanel)
        rightPanel.didMoveToParentViewController(self)
        return rightPanel
    }()
    
    //
    var showingLeftPanel = false
    var showingRightPanel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Controller Containment
        view.addSubview(self.centerVC.view)
        addChildViewController(self.centerVC)
        centerVC.didMoveToParentViewController(self)
        
        // The DiatonicKeyboardViewController will post these notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showPresetList", name: "showPresetList", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAbout", name: "showAbout", object: nil)
        
        ValueIndicator.sharedInstance.indicatorLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(ValueIndicator.sharedInstance.indicatorLabel)
        let views = ["indicator":ValueIndicator.sharedInstance.indicatorLabel]
        let metrics = ["indicatorWidth": 250.0, "indicatorHeight":200.0]
        view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: ValueIndicator.sharedInstance.indicatorLabel, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: ValueIndicator.sharedInstance.indicatorLabel, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[indicator(indicatorWidth)]", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[indicator(indicatorHeight)]", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPresetList() {
        if showingLeftPanel {
            movePanelToOriginalPosition()
        } else {
            var childView = self.leftPanelVC.view
            view.sendSubviewToBack(childView)
            applyShadowToCenterView(true, offset: CGFloat(-2.0))
            UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 0.78, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.centerVC.view.frame.origin = CGPointMake(leftPanelWidth, 0)
            }, completion: { (Bool) -> Void in
                self.showingLeftPanel = true
            })
        }
    }
    
    func showAbout() {
        if showingRightPanel {
            movePanelToOriginalPosition()
        } else { 
            var childView = self.rightPanelVC.view
            view.sendSubviewToBack(childView)
            applyShadowToCenterView(true, offset: 2.0)
            UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 0.78, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.centerVC.view.frame.origin = CGPointMake(CGFloat(-1.0 * rightPanelWidth), 0.0)
            }, completion: { (Bool) -> Void in
                self.showingRightPanel = true
            })
        }
    }
    
    func movePanelToOriginalPosition() {
        UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 0.78, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.centerVC.view.frame.origin = CGPointZero
        }) { (Bool) -> Void in
            self.showingLeftPanel = false
            self.showingRightPanel = false
            self.applyShadowToCenterView(false, offset: CGFloat(0.0))
        }
    }
    
    func applyShadowToCenterView(shadow:Bool, offset:CGFloat) {
        if shadow {
            centerVC.view.layer.shadowColor = UIColor.blackColor().CGColor
            centerVC.view.layer.shadowOpacity = 0.8
            centerVC.view.layer.shadowOffset = CGSizeMake(offset, offset)
        } else {
            centerVC.view.layer.shadowOpacity = 0.0
            centerVC.view.layer.shadowOffset = CGSizeZero
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

