//
//  PresetListTableViewController.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/24/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import UIKit
import CoreData

class PresetListTableViewController: UITableViewController {
    
    var instrument: InstrumentViewController?
    var presets = [Preset]()

    // INIT OVERRIDES
    override init(style: UITableViewStyle) {
        super.init(style: style)
        title = "Presets"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "PresetCell")
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let addBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "createPreset")
         self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Preset")
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [Preset]
        if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [Preset] {
            presets = fetchedResults
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPreset() {
        var alert = UIAlertController(title: "Save", message: "Enter a name for the preset", preferredStyle: UIAlertControllerStyle.Alert)
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as! UITextField
            self.saveName(textField.text)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
            
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveName(name: String) {
        
        // 1. Get managedObjectContext
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        // 2. Create NSManagedObject
        let entity = NSEntityDescription.entityForName("Preset", inManagedObjectContext: managedContext)
        let preset = Preset(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //3. set object values, KVC
        preset.name = name
        preset.att = instrument!.adsrView.attackSlider.value
        preset.dec = instrument!.adsrView.decaySlider.value
        preset.sus = instrument!.adsrView.sustainSlider.value
        preset.rel = instrument!.adsrView.releaseSlider.value
        preset.initial = instrument!.scannedView.initialSlider.value
        preset.tuning = instrument!.scannedView.tuningSlider.value
        preset.detune = instrument!.scannedView.detuneSlider.value
        preset.lfofreq = instrument!.lfoView.freqSlider.value
        preset.lfoamp = instrument!.lfoView.ampSlider.value
        preset.lfotype = instrument!.lfoView.typeSlider.value
        preset.cutoff = instrument!.filterView.cutoffSlider.value
        preset.reso = instrument!.filterView.resoSlider.value
        preset.filttype = instrument!.filterView.typeSlider.value
        preset.fxrate = instrument!.effectView.rateSlider.value
        preset.fxdepth = instrument!.effectView.depthSlider.value
        preset.fxtype = instrument!.effectView.typeSlider.value
        preset.fxmix = instrument!.effectView.mixSlider.value
        
        // 4. save and report
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        // 5. save reference to the NSManagedObject instance
        presets.append(preset)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PresetCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        let preset = presets[indexPath.row]
        cell.textLabel!.text = preset.valueForKey("name") as? String

        return cell
    }

    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the specified item to be editable.
//        return true
//    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the persistent storage from memery
            // 1. Get managedObjectContext
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext!
            
            // 2. Get managedObject instance
            let managedObject = presets[indexPath.row]
            managedContext.deleteObject(managedObject)
            
            // 3. Save managedObjectContext changes
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
            
            // 4. Delete the row from the data source
            presets.removeAtIndex(indexPath.row)

            // 5. let the tableView know appropriately
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let preset = presets[indexPath.row]
        instrument!.adsrView.attackSlider.value = Float(preset.att)
        instrument!.adsrView.decaySlider.value = Float(preset.dec)
        instrument!.adsrView.sustainSlider.value = Float(preset.sus)
        instrument!.adsrView.releaseSlider.value = Float(preset.rel)
        instrument!.scannedView.initialSlider.value = Float(preset.initial)
        instrument!.scannedView.tuningSlider.value = Float(preset.tuning)
        instrument!.scannedView.detuneSlider.value = Float(preset.detune)
        instrument!.lfoView.freqSlider.value = Float(preset.lfofreq)
        instrument!.lfoView.ampSlider.value = Float(preset.lfoamp)
        instrument!.lfoView.typeSlider.value = Float(preset.lfotype)
        instrument!.filterView.cutoffSlider.value = Float(preset.cutoff)
        instrument!.filterView.resoSlider.value = Float(preset.reso)
        instrument!.filterView.typeSlider.value = Float(preset.filttype)
        instrument!.effectView.rateSlider.value = Float(preset.fxrate)
        instrument!.effectView.depthSlider.value = Float(preset.fxdepth)
        instrument!.effectView.typeSlider.value = Float(preset.fxtype)
        instrument!.effectView.mixSlider.value = Float(preset.fxmix)
        instrument!.mixerView.masterSlider.value = Float(preset.master)
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
