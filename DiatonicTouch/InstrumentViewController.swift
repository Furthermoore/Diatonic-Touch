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
    
    // Parameter Subviews
    var osc1Subviews: [UIView] = []
    var osc2Subviews: [UIView] = []
    var adsrSubviews: [UIView] = []

    let osc1DriveSlider = UISlider()
    let osc2DriveSlider = UISlider()
    let osc1SemiSlider = UISlider() // reference for rounding
    let osc2SemiSlider = UISlider()
    let waveform1Control = UISegmentedControl(items: ["pluck", "saw", "metal"]) // reference for csound message sending
    let waveform2Control = UISegmentedControl(items: ["pluck", "saw", "metal"])

    let autolayoutMetrics = ["controlPanelHeight":175.0]
    
    var displayingValue: Bool = false
    
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
        settingsButton.setTitle("Settings", forState: UIControlState.Normal)
        settingsButton.addTarget(self, action: "presentLeftPanel", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Create About button
        let aboutButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        aboutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        aboutButton.setTitle("About", forState: UIControlState.Normal)
        aboutButton.addTarget(self, action: "presentRightPanel", forControlEvents: UIControlEvents.TouchUpInside)
        aboutButton.titleLabel!.textAlignment = NSTextAlignment.Right // for placement on right-hand side
        
        // Create segmentedControl
        let segControl = UISegmentedControl(items: ["osc1", "osc2", "ADSR"])
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
        
        // CREATE SUBVIEWS
        
        // osc 1 subviews
        osc1DriveSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc1DriveSlider.minimumValue = 0.0
        osc1DriveSlider.maximumValue = 1.0
        osc1DriveSlider.value = 0.0
        osc1DriveSlider.enabled = false
        sendSliderValueNotifications(osc1DriveSlider)
        osc1Subviews.append(osc1DriveSlider)
        
        let osc1DriveLabel = UILabel()
        osc1DriveLabel.text = "Mod"
        osc1DriveLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc1Subviews.append(osc1DriveLabel)
        
        let osc1SpreadSlider = UISlider()
        osc1SpreadSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc1SpreadSlider.minimumValue = 0.0
        osc1SpreadSlider.maximumValue = 1.0
        osc1SpreadSlider.value = 0.5
        sendSliderValueNotifications(osc1SpreadSlider)
        osc1Subviews.append(osc1SpreadSlider)
        
        
        let osc1SpreadLabel = UILabel()
        osc1SpreadLabel.text = "Volume"
        osc1SpreadLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc1Subviews.append(osc1SpreadLabel)
        
        let osc1DetuneSlider = UISlider()
        osc1DetuneSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc1DetuneSlider.minimumValue = -0.5
        osc1DetuneSlider.maximumValue = 0.5
        osc1DetuneSlider.value = 0.0
        sendSliderValueNotifications(osc1DetuneSlider)
        osc1Subviews.append(osc1DetuneSlider)

        let osc1DetuneLabel = UILabel()
        osc1DetuneLabel.text = "Detune"
        osc1DetuneLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc1Subviews.append(osc1DetuneLabel)
        
        osc1SemiSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc1SemiSlider.minimumValue = -12.0;
        osc1SemiSlider.maximumValue = 12.0;
        osc1SemiSlider.value = 0.0
        sendSliderValueNotifications(osc1SemiSlider)
        osc1Subviews.append(osc1SemiSlider)
        
        let osc1SemiLabel = UILabel()
        osc1SemiLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc1SemiLabel.text = "Semi"
        osc1Subviews.append(osc1SemiLabel)

        waveform1Control.setTranslatesAutoresizingMaskIntoConstraints(false)
        waveform1Control.selectedSegmentIndex = 0
        waveform1Control.addTarget(self, action: "waveformChanged:", forControlEvents: UIControlEvents.ValueChanged)
        osc1Subviews.append(waveform1Control)
        
        // osc 2 subviews
        osc2DriveSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc2DriveSlider.minimumValue = 0.0
        osc2DriveSlider.maximumValue = 1.0
        osc2DriveSlider.value = 0.0
        osc2DriveSlider.alpha = 0.0
        osc2DriveSlider.enabled = false
        sendSliderValueNotifications(osc2DriveSlider)
        osc2Subviews.append(osc2DriveSlider)
        
        let osc2DriveLabel = UILabel()
        osc2DriveLabel.text = "Mod"
        osc2DriveLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc2DriveLabel.alpha = 0.0
        osc2Subviews.append(osc2DriveLabel)
        
        let osc2SpreadSlider = UISlider()
        osc2SpreadSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc2SpreadSlider.minimumValue = 0.0
        osc2SpreadSlider.maximumValue = 1.0
        osc2SpreadSlider.value = 0.0
        osc2SpreadSlider.alpha = 0.0
        sendSliderValueNotifications(osc2SpreadSlider)
        osc2Subviews.append(osc2SpreadSlider)
        
        let osc2SpreadLabel = UILabel()
        osc2SpreadLabel.text = "Volume"
        osc2SpreadLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc2SpreadLabel.alpha = 0.0
        osc2Subviews.append(osc2SpreadLabel)
        
        let osc2DetuneSlider = UISlider()
        osc2DetuneSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc2DetuneSlider.minimumValue = -0.5
        osc2DetuneSlider.maximumValue = 0.5
        osc2DetuneSlider.value = 0.0
        osc2DetuneSlider.alpha = 0.0
        sendSliderValueNotifications(osc2DetuneSlider)
        osc2Subviews.append(osc2DetuneSlider)
        
        let osc2DetuneLabel = UILabel()
        osc2DetuneLabel.text = "Detune"
        osc2DetuneLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc2DetuneLabel.alpha = 0.0
        osc2Subviews.append(osc2DetuneLabel)
        
        osc2SemiSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc2SemiSlider.minimumValue = -12.0;
        osc2SemiSlider.maximumValue = 12.0;
        osc2SemiSlider.value = 0.0
        osc2SemiSlider.alpha = 0.0
        sendSliderValueNotifications(osc2SemiSlider)
        osc2Subviews.append(osc2SemiSlider)
        
        let osc2SemiLabel = UILabel()
        osc2SemiLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        osc2SemiLabel.text = "Semi"
        osc2SemiLabel.alpha = 0.0
        osc2Subviews.append(osc2SemiLabel)
        
        waveform2Control.setTranslatesAutoresizingMaskIntoConstraints(false)
        waveform2Control.selectedSegmentIndex = 0
        waveform2Control.alpha = 0.0
        waveform2Control.addTarget(self, action: "waveformChanged:", forControlEvents: UIControlEvents.ValueChanged)
        osc2Subviews.append(waveform2Control)
        
        // adsr subviews
        let attackSlider = UISlider()
        attackSlider.minimumValue = 0.02
        attackSlider.maximumValue = 6.00
        attackSlider.value = 0.02
        attackSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        attackSlider.alpha = 0.0
        sendSliderValueNotifications(attackSlider)
        adsrSubviews.append(attackSlider)
        
        let decaySlider = UISlider()
        decaySlider.minimumValue = 0.02
        decaySlider.maximumValue = 3.00
        decaySlider.value = 0.2
        decaySlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        decaySlider.alpha = 0.0
        sendSliderValueNotifications(decaySlider)
        adsrSubviews.append(decaySlider)

        let sustainSlider = UISlider()
        sustainSlider.minimumValue = 0.00
        sustainSlider.maximumValue = 1.0
        sustainSlider.value = 0.7
        sustainSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        sustainSlider.alpha = 0.0
        sendSliderValueNotifications(sustainSlider)
        adsrSubviews.append(sustainSlider)

        let releaseSlider = UISlider()
        releaseSlider.minimumValue = 0.02
        releaseSlider.maximumValue = 10.0
        releaseSlider.value = 1.0
        releaseSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        releaseSlider.alpha = 0.0
        sendSliderValueNotifications(releaseSlider)
        adsrSubviews.append(releaseSlider)

        let attackLabel = UILabel()
        attackLabel.alpha = 0.0
        attackLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        attackLabel.text = "Attack"
        adsrSubviews.append(attackLabel)
        
        let decayLabel = UILabel()
        decayLabel.alpha = 0.0
        decayLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        decayLabel.text = "Decay"
        adsrSubviews.append(decayLabel)
        
        let sustainLabel = UILabel()
        sustainLabel.alpha = 0.0
        sustainLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        sustainLabel.text = "Sustain"
        adsrSubviews.append(sustainLabel)
        
        let releaseLabel = UILabel()
        releaseLabel.alpha = 0.0
        releaseLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        releaseLabel.text = "Release"
        adsrSubviews.append(releaseLabel)
        
        // ADD SUBVIEWS
        // osc1 subviews
        view.addSubview(osc1DriveSlider)
        view.addSubview(osc1DriveLabel)
        view.addSubview(osc1SpreadSlider)
        view.addSubview(osc1SpreadLabel)
        view.addSubview(osc1DetuneSlider)
        view.addSubview(osc1DetuneLabel)
        view.addSubview(osc1SemiSlider)
        view.addSubview(osc1SemiLabel)
        view.addSubview(waveform1Control)
        // osc2 subviews
        view.addSubview(osc2DriveSlider)
        view.addSubview(osc2DriveLabel)
        view.addSubview(osc2SpreadSlider)
        view.addSubview(osc2SpreadLabel)
        view.addSubview(osc2DetuneSlider)
        view.addSubview(osc2DetuneLabel)
        view.addSubview(osc2SemiSlider)
        view.addSubview(osc2SemiLabel)
        view.addSubview(waveform2Control)
        // adsr subviews
        view.addSubview(attackSlider)
        view.addSubview(decaySlider)
        view.addSubview(sustainSlider)
        view.addSubview(releaseSlider)
        view.addSubview(attackLabel)
        view.addSubview(decayLabel)
        view.addSubview(sustainLabel)
        view.addSubview(releaseLabel)
        
        // SET AUTOLAYOUT CONSTRAINTS
        // osc1 layout
        let osc1Views  = ["osc1DriveSlider":osc1DriveSlider, "osc1DriveLabel":osc1DriveLabel, "osc1SpreadSlider":osc1SpreadSlider, "osc1SpreadLabel":osc1SpreadLabel, "osc1DetuneSlider":osc1DetuneSlider, "osc1DetuneLabel":osc1DetuneLabel, "waveform1Control":waveform1Control, "osc1SemiSlider":osc1SemiSlider, "osc1SemiLabel":osc1SemiLabel]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[osc1DriveLabel]-[osc1DriveSlider(>=200)]-[osc1DetuneLabel]-[osc1DetuneSlider(osc1DriveSlider)]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: osc1Views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[osc1SpreadLabel]-[osc1SpreadSlider(>=200)]-[osc1SemiLabel]-[osc1SemiSlider(osc1SpreadSlider)]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: osc1Views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-65-[osc1DriveSlider]-[osc1SpreadSlider]-[waveform1Control]", options: NSLayoutFormatOptions(0), metrics: nil, views: osc1Views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[waveform1Control]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: osc1Views))
        
        // osc2 layout
        let osc2Views = ["osc2DriveSlider":osc2DriveSlider, "osc2DriveLabel":osc2DriveLabel, "osc2SpreadSlider":osc2SpreadSlider, "osc2SpreadLabel":osc2SpreadLabel, "osc2DetuneSlider":osc2DetuneSlider, "osc2DetuneLabel":osc2DetuneLabel, "waveform2Control":waveform2Control, "osc2SemiSlider":osc2SemiSlider, "osc2SemiLabel":osc2SemiLabel]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[osc2DriveLabel]-[osc2DriveSlider(>=200)]-[osc2DetuneLabel]-[osc2DetuneSlider(osc2DriveSlider)]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: osc2Views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[osc2SpreadLabel]-[osc2SpreadSlider(>=200)]-[osc2SemiLabel]-[osc2SemiSlider(osc2SpreadSlider)]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: osc2Views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-65-[osc2DriveSlider]-[osc2SpreadSlider]-[waveform2Control]", options: NSLayoutFormatOptions(0), metrics: nil, views: osc2Views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[waveform2Control]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: osc2Views))
        
        // adsr layout
        let adsrViews = ["attackSlider":attackSlider, "decaySlider":decaySlider, "sustainSlider":sustainSlider, "releaseSlider":releaseSlider, "attackLabel":attackLabel, "decayLabel":decayLabel, "sustainLabel":sustainLabel, "releaseLabel":releaseLabel]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[attackLabel]-[attackSlider(>=200)]-[sustainLabel]-[sustainSlider(attackSlider)]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: adsrViews))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[decayLabel]-[decaySlider(>=200)]-[releaseLabel]-[releaseSlider(decaySlider)]-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: adsrViews))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-65-[attackSlider]-25-[decaySlider]", options: NSLayoutFormatOptions(0), metrics: nil, views: adsrViews))
        
        // ATTACH CONTROLS TO CSOUND
        let csoundUI = CsoundUI(csoundObj: csound)
        
        csoundUI.addSlider(osc1DriveSlider, forChannelName: "drive1", continuous: true)
        csoundUI.addSlider(osc1SpreadSlider, forChannelName: "volume1", continuous: true)
        csoundUI.addSlider(osc1DetuneSlider, forChannelName: "detune1", continuous: true)
        csoundUI.addSlider(osc1SemiSlider, forChannelName: "semi1", continuous: false)
        csoundUI.addSlider(osc2DriveSlider, forChannelName: "drive2", continuous: true)
        csoundUI.addSlider(osc2SpreadSlider, forChannelName: "volume2", continuous: true)
        csoundUI.addSlider(osc2DetuneSlider, forChannelName: "detune2", continuous: true)
        csoundUI.addSlider(osc2SemiSlider, forChannelName: "semi2", continuous: false)
        
        csoundUI.addSlider(attackSlider, forChannelName: "attack", continuous: true)
        csoundUI.addSlider(decaySlider, forChannelName: "decay", continuous: true)
        csoundUI.addSlider(sustainSlider, forChannelName: "sustain", continuous: true)
        csoundUI.addSlider(releaseSlider, forChannelName: "release", continuous: true)
        
    }
    
    func sendSliderValueNotifications(slider: UISlider) {
        slider.addTarget(self, action: "displayValue:", forControlEvents: UIControlEvents.ValueChanged)
        slider.addTarget(self, action: "stopDisplayingValue", forControlEvents: UIControlEvents.TouchUpOutside | UIControlEvents.TouchUpInside)
    }
    
    func displayValue(slider: UISlider) {
        if slider === osc1SemiSlider || slider === osc2SemiSlider {
            var intValue = Int(slider.value)
            ValueIndicator.sharedInstance.indicatorLabel.text = String(format: "%d", arguments: [intValue])
        } else {
            ValueIndicator.sharedInstance.indicatorLabel.text = String(format: "%.3f", arguments: [slider.value])
        }
        ValueIndicator.sharedInstance.fadeInLabel()
    }
    
    func stopDisplayingValue() {
        ValueIndicator.sharedInstance.fadeOutLabel()
    }
    
    func waveformChanged(sender:AnyObject) {
        var message = ""
        if sender === waveform1Control {
            message = "i1 0 -1 0 \(waveform1Control.selectedSegmentIndex)"
            osc1DriveSlider.enabled = waveform1Control.selectedSegmentIndex == 0 ? false : true
        } else if sender === waveform2Control {
            message = "i1 0 -1 1 \(waveform2Control.selectedSegmentIndex)"
            osc2DriveSlider.enabled = waveform2Control.selectedSegmentIndex == 0 ? false : true
        }
        csound.sendScore(message)
    }
    
    func presentLeftPanel() {
        NSNotificationCenter.defaultCenter().postNotificationName("showPresetList", object: nil)
    }
    
    func presentRightPanel() {
        NSNotificationCenter.defaultCenter().postNotificationName("showAbout", object: nil)
    }
    
    func changeParameterSet(sender: AnyObject) {
        let control = sender as! UISegmentedControl
        if control.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                for someView in self.osc1Subviews {
                    someView.alpha = 1.0
                }
                for someView in self.osc2Subviews {
                    someView.alpha = 0.0
                }
                for someView in self.adsrSubviews {
                    someView.alpha = 0.0
                }
            })
        } else if control.selectedSegmentIndex == 1 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                for someView in self.osc1Subviews {
                    someView.alpha = 0.0
                }
                for someView in self.osc2Subviews {
                    someView.alpha = 1.0
                }
                for someView in self.adsrSubviews {
                    someView.alpha = 0.0
                }
            })
        } else if control.selectedSegmentIndex == 2 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                for someView in self.osc1Subviews {
                    someView.alpha = 0.0
                }
                for someView in self.osc2Subviews {
                    someView.alpha = 0.0
                }
                for someView in self.adsrSubviews {
                    someView.alpha = 1.0
                }
            })
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
        let scoreMessage = String(format: "i2.%003d 0 -2 %d %f", arguments: [noteNum, noteNum, noteAmp])
        csound.sendScore(scoreMessage)
    }
    
    func keyReleased(keyboard: DiatonicKeyboardView, params: [String:AnyObject]) {
        let scoreMessage = String(format: "i-2.%003d 0 0", arguments: [params["NoteNum"] as! Int])
        csound.sendScore(scoreMessage)
    }
}
