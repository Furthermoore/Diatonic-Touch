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
    
    let autolayoutMetrics = ["controlPanelHeight":180.0]
    
    lazy var adsrView: ADSRView = {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ADSRView", bundle: bundle)
        let someView = nib.instantiateWithOwner(self, options: nil)[0] as! ADSRView
        someView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return someView
    }()
    
    lazy var scannedView:ScannedView = {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ScannedView", bundle: bundle)
        let someView = nib.instantiateWithOwner(self, options: nil)[0] as! ScannedView
        someView.setTranslatesAutoresizingMaskIntoConstraints(false)
        someView.alpha = 0.0
        return someView
    }()
    
    lazy var lfoView:LFOView = {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "LFOView", bundle: bundle)
        let someView = nib.instantiateWithOwner(self, options: nil)[0] as! LFOView
        someView.setTranslatesAutoresizingMaskIntoConstraints(false)
        someView.alpha = 0.0
        return someView
        }()
    
    lazy var filterView:FilterView = {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "FilterView", bundle: bundle)
        let someView = nib.instantiateWithOwner(self, options: nil)[0] as! FilterView
        someView.setTranslatesAutoresizingMaskIntoConstraints(false)
        someView.alpha = 0.0
        return someView
        }()
    
    lazy var effectView:EffectsView = {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "EffectsView", bundle: bundle)
        let someView = nib.instantiateWithOwner(self, options: nil)[0] as! EffectsView
        someView.setTranslatesAutoresizingMaskIntoConstraints(false)
        someView.alpha = 0.0
        return someView
        }()
    
    lazy var mixerView:MixerView = {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "MixerView", bundle: bundle)
        let someView = nib.instantiateWithOwner(self, options: nil)[0] as! MixerView
        someView.setTranslatesAutoresizingMaskIntoConstraints(false)
        someView.alpha = 0.0
        return someView
        }()
    
    var displayingValue: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createControlPanel()
        createKeyboard()
        
        view.addSubview(adsrView)
        view.addSubview(scannedView)
        view.addSubview(lfoView)
        view.addSubview(filterView)
        view.addSubview(effectView)
        view.addSubview(mixerView)
        
        let views = ["adsrView":adsrView, "scannedView":scannedView, "lfoView":lfoView, "filterView":filterView, "effectView":effectView, "mixerView":mixerView]
        let metrics = ["paramViewOffset":55.0, "paramViewHeight":125.0]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[adsrView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[scannedView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[lfoView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[filterView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[effectView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[mixerView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-paramViewOffset-[adsrView(paramViewHeight)]|", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-paramViewOffset-[scannedView(paramViewHeight)]|", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-paramViewOffset-[lfoView(paramViewHeight)]|", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-paramViewOffset-[filterView(paramViewHeight)]|", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-paramViewOffset-[effectView(paramViewHeight)]|", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-paramViewOffset-[mixerView(paramViewHeight)]|", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))

        
        adsrView.attackSlider.minimumValue = 0.2
        adsrView.attackSlider.maximumValue = 6.0
        adsrView.attackSlider.value = 1.0
        adsrView.decaySlider.minimumValue = 0.01
        adsrView.decaySlider.maximumValue = 1.0
        adsrView.decaySlider.value = 0.1
        adsrView.sustainSlider.minimumValue = 0.0
        adsrView.sustainSlider.maximumValue = 1.0
        adsrView.sustainSlider.value = 0.7
        adsrView.releaseSlider.minimumValue = 0.02
        adsrView.releaseSlider.maximumValue = 6.0
        adsrView.releaseSlider.value = 1.0
        
        scannedView.initialSlider.minimumValue = 50
        scannedView.initialSlider.maximumValue = 59
        scannedView.initialSlider.value = 50
        scannedView.tuningSlider.minimumValue = 101
        scannedView.tuningSlider.maximumValue = 114
        scannedView.tuningSlider.value = 101
        scannedView.detuneSlider.minimumValue = 1.0
        scannedView.detuneSlider.maximumValue = 1.2
        scannedView.detuneSlider.value = 1.0
        
        lfoView.freqSlider.minimumValue = 0
        lfoView.freqSlider.maximumValue = 20
        lfoView.freqSlider.value = 0
        lfoView.ampSlider.minimumValue = 0
        lfoView.ampSlider.maximumValue = 20
        lfoView.ampSlider.value = 0
        lfoView.typeSlider.minimumValue = 0
        lfoView.typeSlider.maximumValue = 5
        lfoView.typeSlider.value = 0
        
        filterView.cutoffSlider.minimumValue = 200
        filterView.cutoffSlider.maximumValue = 22000
        filterView.cutoffSlider.value = 13932
        filterView.resoSlider.minimumValue = 0.1
        filterView.resoSlider.maximumValue = 0.9
        filterView.resoSlider.value = 0.45
        filterView.typeSlider.minimumValue = 0
        filterView.typeSlider.maximumValue = 5
        filterView.typeSlider.value = 0
        
        effectView.rateSlider.minimumValue = 0.1
        effectView.rateSlider.maximumValue = 12.0
        effectView.rateSlider.value = 5.0
        effectView.depthSlider.minimumValue = 100
        effectView.depthSlider.maximumValue = 2000
        effectView.depthSlider.value = 800.0
        effectView.typeSlider.minimumValue = 0
        effectView.typeSlider.maximumValue = 5
        effectView.typeSlider.value = 0
        effectView.mixSlider.minimumValue = 0.0
        effectView.mixSlider.maximumValue = 1.0
        effectView.mixSlider.value = 0.0
        
        mixerView.masterSlider.minimumValue = 0.0
        mixerView.masterSlider.maximumValue = 1.0
        mixerView.masterSlider.value = 0.7
        
        sendSliderValueNotifications(adsrView.attackSlider)
        sendSliderValueNotifications(adsrView.decaySlider)
        sendSliderValueNotifications(adsrView.sustainSlider)
        sendSliderValueNotifications(adsrView.releaseSlider)
        sendSliderValueNotifications(scannedView.initialSlider)
        sendSliderValueNotifications(scannedView.tuningSlider)
        sendSliderValueNotifications(scannedView.detuneSlider)
        sendSliderValueNotifications(lfoView.freqSlider)
        sendSliderValueNotifications(lfoView.ampSlider)
        sendSliderValueNotifications(lfoView.typeSlider)
        sendSliderValueNotifications(filterView.cutoffSlider)
        sendSliderValueNotifications(filterView.resoSlider)
        sendSliderValueNotifications(filterView.typeSlider)
        sendSliderValueNotifications(effectView.rateSlider)
        sendSliderValueNotifications(effectView.depthSlider)
        sendSliderValueNotifications(effectView.typeSlider)
        sendSliderValueNotifications(effectView.mixSlider)
        sendSliderValueNotifications(mixerView.masterSlider)
        
        let csoundUI = CsoundUI(csoundObj: csound)
        csoundUI.addSlider(adsrView.attackSlider, forChannelName: "attack", continuous: true)
        csoundUI.addSlider(adsrView.decaySlider, forChannelName: "decay", continuous: true)
        csoundUI.addSlider(adsrView.sustainSlider, forChannelName: "sustain", continuous: true)
        csoundUI.addSlider(adsrView.releaseSlider, forChannelName: "release", continuous: true)
        csoundUI.addSlider(scannedView.initialSlider, forChannelName: "initial", continuous: false)
        csoundUI.addSlider(scannedView.tuningSlider, forChannelName: "tuning", continuous: false)
        csoundUI.addSlider(scannedView.detuneSlider, forChannelName: "detMult", continuous: true)
        csoundUI.addSlider(lfoView.freqSlider, forChannelName: "cpslfo", continuous: false)
        csoundUI.addSlider(lfoView.ampSlider, forChannelName: "amplfo", continuous: false)
        csoundUI.addSlider(lfoView.typeSlider, forChannelName: "lfotype", continuous: false)
        csoundUI.addSlider(filterView.cutoffSlider, forChannelName: "cutoff", continuous: true)
        csoundUI.addSlider(filterView.resoSlider, forChannelName: "res", continuous: true)
        csoundUI.addSlider(filterView.typeSlider, forChannelName: "filters", continuous: false)
        csoundUI.addSlider(effectView.rateSlider, forChannelName: "fxrate", continuous: true)
        csoundUI.addSlider(effectView.depthSlider, forChannelName: "fxdepth", continuous: true)
        csoundUI.addSlider(effectView.mixSlider, forChannelName: "fxmix", continuous: true)
        csoundUI.addSlider(effectView.typeSlider, forChannelName: "effects", continuous: false)
        csoundUI.addSlider(mixerView.masterSlider, forChannelName: "master", continuous: true)
        
        csound.addListener(self)
        csound.play(NSBundle.mainBundle().pathForResource("scanned", ofType: "csd"))
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
    
    func sendSliderValueNotifications(slider: UISlider) {
        slider.addTarget(self, action: "displayValue:", forControlEvents: UIControlEvents.ValueChanged)
        slider.addTarget(self, action: "stopDisplayingValue", forControlEvents: UIControlEvents.TouchUpOutside | UIControlEvents.TouchUpInside)
    }
    
    func displayValue(slider: UISlider) {
        ValueIndicator.sharedInstance.fadeInLabel()
        ValueIndicator.sharedInstance.indicatorLabel.text = String(format: "%.1f", arguments: [slider.value])
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
        if let control = sender as? UISegmentedControl {
            if control.selectedSegmentIndex == 0 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.adsrView.alpha = 1.0
                    self.scannedView.alpha = 0.0
                    self.lfoView.alpha = 0.0
                    self.filterView.alpha = 0.0
                    self.effectView.alpha = 0.0
                    self.mixerView.alpha = 0.0
                })
            } else if control.selectedSegmentIndex == 1 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.adsrView.alpha = 0.0
                    self.scannedView.alpha = 1.0
                    self.lfoView.alpha = 0.0
                    self.filterView.alpha = 0.0
                    self.effectView.alpha = 0.0
                    self.mixerView.alpha = 0.0
                })
            } else if control.selectedSegmentIndex == 2 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.adsrView.alpha = 0.0
                    self.scannedView.alpha = 0.0
                    self.lfoView.alpha = 1.0
                    self.filterView.alpha = 0.0
                    self.effectView.alpha = 0.0
                    self.mixerView.alpha = 0.0
                })
            } else if control.selectedSegmentIndex == 3 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.adsrView.alpha = 0.0
                    self.scannedView.alpha = 0.0
                    self.lfoView.alpha = 0.0
                    self.filterView.alpha = 1.0
                    self.effectView.alpha = 0.0
                    self.mixerView.alpha = 0.0
                })
            } else if control.selectedSegmentIndex == 4 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.adsrView.alpha = 0.0
                    self.scannedView.alpha = 0.0
                    self.lfoView.alpha = 0.0
                    self.filterView.alpha = 0.0
                    self.effectView.alpha = 1.0
                    self.mixerView.alpha = 0.0
                })

            } else if control.selectedSegmentIndex == 5 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.adsrView.alpha = 0.0
                    self.scannedView.alpha = 0.0
                    self.lfoView.alpha = 0.0
                    self.filterView.alpha = 0.0
                    self.effectView.alpha = 0.0
                    self.mixerView.alpha = 1.0
                })
            }
        }
        
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
