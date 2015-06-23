//
//  DiatonicKeyboardView.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/12/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit

protocol DiatonicKeyboardViewDelegate {
    func keyPressed(keyboard:DiatonicKeyboardView, params:[String:AnyObject])
    func keyReleased(keyboard:DiatonicKeyboardView, params:[String:AnyObject])
}

class DiatonicKeyboardView: UIView {

    var delegate:DiatonicKeyboardViewDelegate?
    
    var scaleSteps:Int = 7
    var octaveRange:Int = 1
    var octave:Int = 3
    var root:Int = 0
    var tonality: Int = 0
    
    var scale:[NSNumber] = []
    
    var noteLabels = [UILabel]()
    var sleekBarViews = [UIView]() //
    
    // start with 8 keys, indexed from left to right across the keyboard
    var keyStatus = [Bool](count:8, repeatedValue: false)   // true would mean the key is currently pressed
    var currentTouches = NSMutableSet()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        multipleTouchEnabled = true
        setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // DRAWING THE KEYBOARD
    
    let lightGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)   // Create color object references.
    let darkGray = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)       // These will be used to draw different gradients,
    let darkBlue = UIColor(red: 0.392, green: 0.584, blue: 0.698, alpha: 1.0) // depending on either the status or placement of each key
    let lightBlue = UIColor(red: 0.58, green: 0.733, blue: 0.827, alpha: 1.0)
    
    override func drawRect(rect: CGRect) {
        let numKeys = octaveRange * scaleSteps + 1
        let keyWidth:CGFloat = frame.size.width / CGFloat(numKeys)
        let keyHeight:CGFloat = frame.size.height
        
        // Draw a gradient for each key
        for var i = 0; i < numKeys; i++ { // The root(first) note of every octave will be a black key
            let myRect = CGRectMake(CGFloat(i)*keyWidth, 0.0, keyWidth, keyHeight)
            let context = UIGraphicsGetCurrentContext()
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            if keyStatus[i] == true { // key is currently pressed down! Draw a light blue gradient
                drawLinearGradient(context, rect: myRect, startColor: darkBlue, endColor: lightBlue)
            } else if i % scaleSteps == 0 { // the root(first) note of each scale drawn black
                drawLinearGradient(context, rect: myRect, startColor: UIColor.blackColor(), endColor: darkGray)
            } else { // all other keys drawn gray
                drawLinearGradient(context, rect: myRect, startColor: lightGray, endColor: UIColor.whiteColor())
            }
        }
        
        // Draw line separators for each key
        for i in 0...self.octaveRange*self.scaleSteps-1 {
            let stroke = UIBezierPath()
            UIColor.blackColor().setStroke()
            stroke.lineWidth = 2.0
            stroke.moveToPoint(CGPointMake(CGFloat(i+1)*keyWidth, 0))
            stroke.addLineToPoint(CGPointMake(CGFloat(i+1)*keyWidth, keyHeight))
            stroke.stroke()
        }
    }
    
    func drawLinearGradient(context:CGContextRef, rect:CGRect, startColor:UIColor, endColor:UIColor) {
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.0, 1.0]
        let colors = [startColor, endColor].map{(color:UIColor!) -> AnyObject! in return color.CGColor as AnyObject!} as NSArray
        let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
        
        let startPoint = CGPointMake(rect.origin.x, rect.size.height/2.0)
        let endPoint = CGPointMake(rect.origin.x+rect.size.width, rect.size.height/2.0)
        
        CGContextSaveGState(context)
        CGContextAddRect(context, rect)
        CGContextClip(context)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(context)
    }
    
    // MARK: UIResponder - Handling Touch Events
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches {
            currentTouches.addObject(touch)
        }
        updateKeyStates()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        updateKeyStates()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches {
            currentTouches.removeObject(touch)
        }
        updateKeyStates()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        for touch in touches {
            currentTouches.removeObject(touch)
        }
        updateKeyStates()
    }
    
    func updateKeyStates() {
        let touches = currentTouches.allObjects
        let count = touches.count
        let totalNumKeys = octaveRange * scaleSteps + 1
        var currentKeyState = [Bool](count: totalNumKeys, repeatedValue: false)
        var currentKeyAmp = [Float](count:totalNumKeys, repeatedValue:0.0)
        var currentKeyDur = [Float](count:totalNumKeys, repeatedValue:0.0)
        
        for var i = 0; i < count; i++ {
            let touch = touches[i] as! UITouch
            let point = touch.locationInView(self)
            let index = self.getKeyboardKey(point)
            if index != -1 {
                currentKeyState[index] = true
                currentKeyAmp[index] = getKeyDownAmplitude(point)
                currentKeyDur[index] = getKeyDownDuration(forPoint: point, andKey: index)
            }
        }
        
        var keysUpdated = false
        
        for i in 0...totalNumKeys-1 {
            if keyStatus[i] != currentKeyState[i] {
                keysUpdated = true
                keyStatus[i] = currentKeyState[i]
                if currentKeyState[i] {
                    let params: [String:AnyObject] = ["NoteNum":Int(self.scale[i]), "NoteAmp":currentKeyAmp[i], "MinimumDuration":currentKeyDur[i]]
                    self.delegate?.keyPressed(self, params: params)
                } else {
                    let params: [String:AnyObject] = ["NoteNum":Int(self.scale[i])]
                    self.delegate?.keyReleased(self, params: params)
                }
            }
        }
        
        if keysUpdated {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.setNeedsDisplay()
            })
        }
        
    }

    func getKeyboardKey(point:CGPoint) -> Int {
        var keyNum = -1
        let totalNumKeys = octaveRange * scaleSteps + 1
        let width = self.frame.size.width / CGFloat(totalNumKeys)
        
        for var i = 0; i < totalNumKeys; i++ {
            if CGRectContainsPoint(CGRectMake(CGFloat(i)*width, 0.0, width, self.frame.size.height), point) {
                keyNum = i
            }
        }
        return keyNum
    }
    
    func getKeyDownAmplitude(point: CGPoint) -> Float {
        return Float((self.frame.size.height - point.y) / self.frame.size.height)
    }
    
    func getKeyDownDuration(forPoint point: CGPoint, andKey key: Int) -> Float {
        let keyWidth: CGFloat = self.frame.size.width / CGFloat(octaveRange * scaleSteps + 1)
        let keyNum = CGFloat(key)
        let result = Float((((keyWidth * keyNum) + keyWidth) - point.x) / keyWidth) * 5.0
        println(result)
        return result
    }
    
    func recreateKeyLabels() {
        
        let barWidth:   CGFloat = frame.size.width / CGFloat(octaveRange * scaleSteps + 1)
        let barHeight:  CGFloat = 2.0
        var barYOffset: CGFloat = 60.0
        var labelYOffset: CGFloat = 30.0
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            barYOffset = 100.0
            labelYOffset = 50.0
        }
        
        for label in noteLabels {
            label.removeFromSuperview() // labels' retain count drops to 1
        }    // We can observe these changes using Applications -> Instruments -> Allocations
        for sleekBar in sleekBarViews {
            sleekBar.removeFromSuperview()
        }
        noteLabels = [UILabel]() // label's retain count hits 0 
        sleekBarViews = [UIView]()
        
        self.scale = MusicTheory.chordScaleForRoot(root, tonality: tonality, steps: scaleSteps, range: octaveRange, octave: octave) as! [NSNumber]
        if scaleSteps*octaveRange+1 < 25 { // less than 25 keys on display? -> give each a note label
            for var i = 0; i < scaleSteps*octaveRange+1; i++ {
                let label = UILabel(frame: CGRectMake(0.0, 0.0, 40.0, 30.0))
                noteLabels.append(label)
                label.textAlignment = NSTextAlignment.Center
                let midiNoteNumber = Int(self.scale[i])
                label.text = MusicTheory.MIDIStringForNumber(midiNoteNumber)
                let width = self.frame.size.width / CGFloat(self.scaleSteps*self.octaveRange+1)
                label.center = CGPointMake(CGFloat(i)*width+(width/2.0), labelYOffset)
                
                let sleekBar = UIView()
                sleekBarViews.append(sleekBar)
                sleekBar.setTranslatesAutoresizingMaskIntoConstraints(false)
                sleekBar.layer.shadowOffset = CGSizeMake(2.0, 2.0)
                sleekBar.layer.shadowOpacity = 0.8
                sleekBar.layer.cornerRadius = 10.0
                
                if i % scaleSteps == 0 {
                    label.textColor = UIColor.whiteColor()
                    sleekBar.backgroundColor = UIColor.whiteColor()
                    sleekBar.layer.shadowColor = UIColor.whiteColor().CGColor
                } else {
                    label.textColor = UIColor.blackColor()
                    sleekBar.backgroundColor = UIColor.blackColor()
                    sleekBar.layer.shadowColor = UIColor.blackColor().CGColor
                }
                
                addSubview(label)
                addSubview(sleekBar)
                
                let barXOffset: CGFloat = barWidth * CGFloat(i)
                
                addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-barXOffset-[sleekBar(barWidth)]", options: NSLayoutFormatOptions(0), metrics: ["barXOffset":barXOffset, "barWidth":barWidth], views: ["sleekBar":sleekBar]))
                addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-barYOffset-[sleekBar(barHeight)]", options: NSLayoutFormatOptions(0), metrics: ["barYOffset":barYOffset, "barHeight":barHeight], views: ["sleekBar":sleekBar]))
            }
        } else { // only black keys are labeled with pitch
            for var i = 0; i < octaveRange+1; i++ {
                let label = UILabel(frame: CGRectMake(0.0, 0.0, 40.0, 30.0))
                noteLabels.append(label)
                label.textAlignment = NSTextAlignment.Center
                let midiNoteNumber = Int(self.scale[i])
                label.text = MusicTheory.MIDIStringForNumber(midiNoteNumber)
                let width = self.frame.size.width / CGFloat(self.scaleSteps*self.octaveRange+1)
                label.center = CGPointMake(CGFloat(i)*width+(width/2.0), labelYOffset)
                
                
                let sleekBar = UIView()
                sleekBarViews.append(sleekBar)
                sleekBar.setTranslatesAutoresizingMaskIntoConstraints(false)
                sleekBar.layer.shadowOffset = CGSizeMake(2.0, 2.0)
                sleekBar.layer.shadowOpacity = 0.8
                sleekBar.layer.cornerRadius = 10.0
                
                if i % scaleSteps == 0 {
                    label.textColor = UIColor.whiteColor()
                    sleekBar.backgroundColor = UIColor.whiteColor()
                    sleekBar.layer.shadowColor = UIColor.whiteColor().CGColor
                } else {
                    label.textColor = UIColor.blackColor()
                    sleekBar.backgroundColor = UIColor.blackColor()
                    sleekBar.layer.shadowColor = UIColor.blackColor().CGColor
                }
                addSubview(label)
                addSubview(sleekBar)
                
                let barXOffset: CGFloat = barWidth * CGFloat(i)
                
                addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-barXOffset-[sleekBar(barWidth)]", options: NSLayoutFormatOptions(0), metrics: ["barXOffset":barXOffset, "barWidth":barWidth], views: ["sleekBar":sleekBar]))
                addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-barYOffset-[sleekBar(barHeight)]", options: NSLayoutFormatOptions(0), metrics: ["barYOffset":barYOffset, "barHeight":barHeight], views: ["sleekBar":sleekBar]))
            }
        }
        keyStatus = [Bool](count: scaleSteps*octaveRange+1, repeatedValue: false)
        setNeedsDisplay()
    }
}
