//
//  LeftPanelViewController.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/12/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit

class SettingsPanelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let headerHeight: CGFloat = 55.0
    
    let scaleStepsPickerView = UIPickerView()
    let octavesControl = UISegmentedControl(items: ["1", "2", "3", "4"])
    let keyCenterPickerView = UIPickerView()
    let octavePickerView = UIPickerView()
    let tonalityControl = UISegmentedControl(items: ["Major", "Minor"])
    
    weak var diatonicKeyboard: DiatonicKeyboardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRectMake(0.0, 0.0, leftPanelWidth, view.frame.size.height)
        
        let titleLabel = UILabel(frame: CGRectMake(0.0, 0.0, leftPanelWidth, headerHeight))
        titleLabel.text = "Keyboard Settings"
        titleLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(titleLabel)
        
        let footerLabel = UILabel(frame: CGRectMake(0.0, view.frame.size.height - headerHeight, view.frame.size.width, headerHeight))
        footerLabel.text = "<-- Swipe for more settings -->"
        footerLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(footerLabel)
        
        let scrollView = UIScrollView(frame: CGRectMake(0.0, headerHeight, leftPanelWidth, view.frame.size.height - (headerHeight * 2.0)))
        view.addSubview(scrollView)
        
        scrollView.addSubview(firstContentView())
        scrollView.addSubview(secondContentView())
        scrollView.addSubview(thirdContentView())
        scrollView.addSubview(fourthContentView())
        scrollView.addSubview(fifthContentView())
        
        scrollView.contentSize = CGSizeMake(leftPanelWidth*5, view.frame.size.height - (headerHeight * 2.0))
        scrollView.pagingEnabled = true
    }
    
    func firstContentView() -> UIView {
        let contentView1 = UIView(frame: CGRectMake(0.0, 0.0, leftPanelWidth, view.frame.size.height - headerHeight))
        
        let scaleStepsLabel = UILabel()
        scaleStepsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        scaleStepsLabel.text = "Scale Steps"
        scaleStepsLabel.textAlignment = NSTextAlignment.Center
        contentView1.addSubview(scaleStepsLabel)
        
        scaleStepsPickerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        scaleStepsPickerView.delegate = self
        scaleStepsPickerView.dataSource = self
        scaleStepsPickerView.selectRow(6, inComponent: 0, animated: false)
        scaleStepsPickerView.layer.borderColor = UIColor.blackColor().CGColor
        scaleStepsPickerView.layer.borderWidth = 2.0
        scaleStepsPickerView.clipsToBounds = true
        contentView1.addSubview(scaleStepsPickerView)
        
        // AUTOLAYOUT
        
        let views = ["scaleStepsPickerView":scaleStepsPickerView, "scaleStepsLabel":scaleStepsLabel]
        let metrics = ["pickerViewWidth":view.frame.size.width]
        
        contentView1.addConstraint(NSLayoutConstraint(item: contentView1, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: scaleStepsPickerView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        contentView1.addConstraint(NSLayoutConstraint(item: contentView1, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: scaleStepsPickerView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 40.0))
        contentView1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[scaleStepsLabel]-[scaleStepsPickerView]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        contentView1.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[scaleStepsPickerView(pickerViewWidth)]", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
        
        return contentView1
    }
    
    func secondContentView() -> UIView {
        let contentView2 = UIView(frame: CGRectMake(leftPanelWidth, 0.0, leftPanelWidth, view.frame.size.height - headerHeight))
        
        let octavesLabel = UILabel()
        octavesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        octavesLabel.text = "Octaves"
        octavesLabel.textAlignment = NSTextAlignment.Center
        contentView2.addSubview(octavesLabel)
        
        octavesControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        octavesControl.selectedSegmentIndex = 0
        octavesControl.addTarget(self, action: "segmentedControlChange:", forControlEvents: UIControlEvents.ValueChanged)
        contentView2.addSubview(octavesControl)
        
        // AUTOLAYOUT
        
        let views = ["octavesControl":octavesControl, "octavesLabel":octavesLabel]
        
        contentView2.addConstraint(NSLayoutConstraint(item: contentView2, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: octavesControl, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        contentView2.addConstraint(NSLayoutConstraint(item: contentView2, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: octavesControl, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 40.0))
        contentView2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[octavesLabel]-[octavesControl]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        contentView2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[octavesControl]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        return contentView2
    }
    
    func thirdContentView() -> UIView {
        let contentView3 = UIView(frame: CGRectMake(leftPanelWidth * 2.0, 0.0, leftPanelWidth, view.frame.size.height - headerHeight))
        
        let keyCenterLabel = UILabel()
        keyCenterLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        keyCenterLabel.text = "Key Center"
        keyCenterLabel.textAlignment = NSTextAlignment.Center
        contentView3.addSubview(keyCenterLabel)
        
        keyCenterPickerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        keyCenterPickerView.delegate = self
        keyCenterPickerView.dataSource = self
        keyCenterPickerView.selectRow(11, inComponent: 0, animated: false)
        keyCenterPickerView.layer.borderColor = UIColor.blackColor().CGColor
        keyCenterPickerView.layer.borderWidth = 2.0
        keyCenterPickerView.clipsToBounds = true
        contentView3.addSubview(keyCenterPickerView)
        
        // AUTOLAYOUT
        
        let views = ["keyCenterPickerView":keyCenterPickerView, "keyCenterLabel":keyCenterLabel]
        let metrics = ["pickerWidth":view.frame.size.width, "pickerHeight":30.0]
        
        contentView3.addConstraint(NSLayoutConstraint(item: contentView3, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: keyCenterPickerView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        contentView3.addConstraint(NSLayoutConstraint(item: contentView3, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: keyCenterPickerView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 40.0))
        contentView3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[keyCenterLabel]-[keyCenterPickerView]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        contentView3.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[keyCenterPickerView(pickerWidth)]", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))

        return contentView3
    }
    
    func fourthContentView() -> UIView {
        let contentView4 = UIView(frame: CGRectMake(leftPanelWidth * 3.0, 0.0, leftPanelWidth, view.frame.size.height - headerHeight))
        
        let octaveLabel = UILabel()
        octaveLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        octaveLabel.text = "Starting Octave"
        octaveLabel.textAlignment = NSTextAlignment.Center
        contentView4.addSubview(octaveLabel)
        
        let octaveInfoLabel = UILabel()
        octaveInfoLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        octaveInfoLabel.text = "3 = octave of Middle C, A-440"
        octaveInfoLabel.textAlignment = NSTextAlignment.Center
        contentView4.addSubview(octaveInfoLabel)
        
        octavePickerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        octavePickerView.delegate = self
        octavePickerView.dataSource = self
        octavePickerView.selectRow(5, inComponent: 0, animated: false)
        octavePickerView.layer.borderColor = UIColor.blackColor().CGColor
        octavePickerView.layer.borderWidth = 2.0
        octavePickerView.clipsToBounds = true
        contentView4.addSubview(octavePickerView)
        
        // AUTOLAYOUT
        
        let views = ["octavePickerView":octavePickerView, "octaveLabel":octaveLabel, "octaveInfoLabel":octaveInfoLabel]
        let metrics = ["pickerWidth":view.frame.size.width, "pickerHeight":30.0]
        
        contentView4.addConstraint(NSLayoutConstraint(item: contentView4, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: octavePickerView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        contentView4.addConstraint(NSLayoutConstraint(item: contentView4, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: octavePickerView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 40.0))
        contentView4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[octaveLabel]-[octavePickerView]-[octaveInfoLabel]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        contentView4.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[octavePickerView(pickerWidth)]", options: NSLayoutFormatOptions(0), metrics: metrics, views: views))
        
        return contentView4
    }
    
    func fifthContentView() -> UIView {
        let contentView5 = UIView(frame: CGRectMake(leftPanelWidth * 4.0, 0.0, leftPanelWidth, view.frame.size.height - headerHeight))
        
        let tonalityLabel = UILabel()
        tonalityLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tonalityLabel.text = "Tonality"
        tonalityLabel.textAlignment = NSTextAlignment.Center
        contentView5.addSubview(tonalityLabel)
        
        tonalityControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        tonalityControl.selectedSegmentIndex = 0
        tonalityControl.addTarget(self, action: "segmentedControlChange:", forControlEvents: UIControlEvents.ValueChanged)
        contentView5.addSubview(tonalityControl)
        
        // AUTOLAYOUT
        
        let views = ["tonalityControl":tonalityControl, "tonalityLabel":tonalityLabel]
        
        contentView5.addConstraint(NSLayoutConstraint(item: contentView5, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: tonalityControl, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        contentView5.addConstraint(NSLayoutConstraint(item: contentView5, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: tonalityControl, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 40.0))
        contentView5.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[tonalityLabel]-[tonalityControl]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        contentView5.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[tonalityControl]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        return contentView5
    }

    // MARK: UIPickerViewDelegate & UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === scaleStepsPickerView {
            return 7
        } else if pickerView === keyCenterPickerView {
            return 12
        } else if pickerView === octavePickerView {
            return 11
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(50.0)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView === scaleStepsPickerView {
            return "\(row + 1)"
        } else if pickerView === keyCenterPickerView {
            switch row {
            case 0:  return "B"
            case 1:  return "Bb"
            case 2:  return "A"
            case 3:  return "Ab"
            case 4:  return "G"
            case 5:  return "Gb"
            case 6:  return "F"
            case 7:  return "E"
            case 8:  return "Eb"
            case 9:  return "D"
            case 10: return "Db"
            case 11: return "C"
            default: return "C"
            }
        } else if pickerView === octavePickerView {
            switch row {
            case 0: return "8"
            case 1: return "7"
            case 2: return "6"
            case 3: return "5"
            case 4: return "4"
            case 5: return "3"
            case 6: return "2"
            case 7: return "1"
            case 8: return "0"
            case 9: return "-1"
            case 10: return "-2"
            default: return "3" // 3 => the octave of Middle C
            }
        }
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === scaleStepsPickerView {
            diatonicKeyboard?.scaleSteps = row + 1
        } else if pickerView === keyCenterPickerView {
            diatonicKeyboard?.root = (11 - row)
        } else if pickerView === octavePickerView {
            diatonicKeyboard?.octave = (8 - row)
        }
        diatonicKeyboard?.recreateKeyLabels()
    }
    
    func segmentedControlChange(sender:AnyObject) {
        if sender === octavesControl {
            let segControl = sender as! UISegmentedControl
            diatonicKeyboard?.octaveRange = segControl.selectedSegmentIndex + 1
        } else if sender === tonalityControl {
            let segControl = sender as! UISegmentedControl
            diatonicKeyboard?.tonality = segControl.selectedSegmentIndex
        }
        diatonicKeyboard?.recreateKeyLabels()
    }
}
