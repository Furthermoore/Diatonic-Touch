//
//  CenterViewController.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/12/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit

class InstrumentViewController: UIViewController, CsoundObjListener, DiatonicKeyboardViewDelegate {
    
    let diatonicKeyboard = DiatonicKeyboardView(frame: CGRectZero)
    
    let csound = CsoundObj()
    
    let autolayoutMetrics = ["controlPanelHeight":175.0]
    
    var displayingValue: Bool = false
    
    // PARAMETER SUBVIEWS
    let adsrView = UIView()
    let attackSlider = UISlider()
    let decaySlider = UISlider()
    let sustainSlider = UISlider()
    let releaseSlider = UISlider()
    
    let scannedView = UIView()
    let initialSlider = UISlider()
    let tuningSlider = UISlider()
    let detMultSlider = UISlider()
    
    let lfoView = UIView()
    let lfoAmpSlider = UISlider()
    let lfoCPSSlider = UISlider()
    let lfoTypeSlider = UISlider()
    
    let filterView = UIView()
    let flCutoffSlider = UISlider()
    let flResSlider = UISlider()
    let filtersSlider = UISlider()
    
    let effectView = UIView()
    let effectsSlider = UISlider()
    let effectsRateSlider = UISlider()
    let effectsDepthSlider = UISlider()
    let effectsMixSlider = UISlider()
    
    let mixView = UIView()
    let masterSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createControlPanel()
        createKeyboard()
        createParameterSubviews()
        
        csound.addListener(self)
        csound.play(NSBundle.mainBundle().pathForResource("midiTest", ofType: "csd"))
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
        settingsButton.setTitle("Key Settings", forState: UIControlState.Normal)
        settingsButton.addTarget(self, action: "presentLeftPanel", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Create About button
        let aboutButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        aboutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        aboutButton.setTitle("Presets", forState: UIControlState.Normal)
        aboutButton.addTarget(self, action: "presentRightPanel", forControlEvents: UIControlEvents.TouchUpInside)
        aboutButton.titleLabel!.textAlignment = NSTextAlignment.Right // for placement on right-hand side
        
        // Create segmentedControl
        let segControl = UISegmentedControl(items: ["ADSR", "SCANNED", "LFO", "FILTER", "EFFECT", "MIX"])
        segControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        segControl.addTarget(self, action: "changeParameterSet:", forControlEvents: UIControlEvents.ValueChanged)
        segControl.selectedSegmentIndex = 0
        
        // add the views.
        // self.view & menuBar will retain these subviews;
        // we won't be needing further reference to them after this.
        menuBar.addSubview(settingsButton)
        menuBar.addSubview(aboutButton)
        menuBar.addSubview(segControl)
        self.view.addSubview(menuBar)

        // Autolayout constraints
        let views = ["menuBar":menuBar, "settingsButton":settingsButton, "aboutButton":aboutButton, "segControl":segControl]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[menuBar(controlPanelHeight)]", options: NSLayoutFormatOptions(0), metrics: autolayoutMetrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[menuBar]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        menuBar.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[settingsButton(100)]-[segControl]-[aboutButton(100)]|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: views))
        menuBar.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[settingsButton]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
    }
    
    func createKeyboard() {
        diatonicKeyboard.delegate = self
        view.addSubview(diatonicKeyboard)
        let views = ["diatonicKeyboard":diatonicKeyboard]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-controlPanelHeight-[diatonicKeyboard]|", options: NSLayoutFormatOptions(0), metrics: autolayoutMetrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[diatonicKeyboard]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

    }
    
    func createParameterSubviews() {
        
        // CREATE ADSR VIEWS
        attackSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        attackSlider.minimumValue = 0.02
        attackSlider.maximumValue = 6.0
        sendSliderValueNotifications(attackSlider)
        
        decaySlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        decaySlider.minimumValue = 0.0
        decaySlider.maximumValue = 1.0
        sendSliderValueNotifications(decaySlider)
        
        sustainSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        sustainSlider.minimumValue = 0.0
        sustainSlider.maximumValue = 1.0
        sendSliderValueNotifications(sustainSlider)
        
        releaseSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        releaseSlider.minimumValue = 0.02
        releaseSlider.maximumValue = 6.0
        sendSliderValueNotifications(releaseSlider)
        
        attackLabel = UI
        
        adsrView.addSubview(attackSlider)
        adsrView.addSubview(decaySlider)
        adsrView.addSubview(sustainSlider)
        adsrView.addSubview(releaseSlider)
        
        
    }
    
    func sendSliderValueNotifications(slider: UISlider) {
        slider.addTarget(self, action: "displayValue:", forControlEvents: UIControlEvents.ValueChanged)
        slider.addTarget(self, action: "stopDisplayingValue", forControlEvents: UIControlEvents.TouchUpOutside | UIControlEvents.TouchUpInside)
    }
    
    func displayValue(slider: UISlider) {
        ValueIndicator.sharedInstance.fadeInLabel()
    }
    
    func stopDisplayingValue() {
        ValueIndicator.sharedInstance.fadeOutLabel()
    }
    
    func presentLeftPanel() {
        NSNotificationCenter.defaultCenter().postNotificationName("showPresetList", object: nil)
    }
    
    func presentRightPanel() {
        NSNotificationCenter.defaultCenter().postNotificationName("showAbout", object: nil)
    }
    
    func changeParameterSet(sender: AnyObject) {
        
    }
    
    // MARK: CsoundObjListener
    
    func csoundObjCompleted(csoundObj: CsoundObj!) {
        println("csound complete")
    }
    
    func csoundObjStarted(csoundObj: CsoundObj!) {
        println("csound started")
    }
    
    // MARK : DiatonicKeyboardViewDelegate
    func keyPressed(keyboard: DiatonicKeyboardView, params: [String:AnyObject]) {
        let noteNum: Int = params["NoteNum"] as! Int
        let noteAmp: Float = params["NoteAmp"] as! Float
        let scoreMessage = String(format: "i1.%003d 0 -2 %d %f", arguments: [noteNum, noteNum, noteAmp])
        csound.sendScore(scoreMessage)
    }
    
    func keyReleased(keyboard: DiatonicKeyboardView, params: [String:AnyObject]) {
        let scoreMessage = String(format: "i-1.%003d 0 0", arguments: [params["NoteNum"] as! Int])
        csound.sendScore(scoreMessage)
    }
}
