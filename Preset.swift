//
//  Preset.swift
//  DiatonicTouch
//
//  Created by Dan Moore on 6/25/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

import Foundation
import CoreData

class Preset: NSManagedObject {

    @NSManaged var att: NSNumber
    @NSManaged var cutoff: NSNumber
    @NSManaged var dec: NSNumber
    @NSManaged var detune: NSNumber
    @NSManaged var filttype: NSNumber
    @NSManaged var fxdepth: NSNumber
    @NSManaged var fxmix: NSNumber
    @NSManaged var fxrate: NSNumber
    @NSManaged var fxtype: NSNumber
    @NSManaged var initial: NSNumber
    @NSManaged var lfoamp: NSNumber
    @NSManaged var lfofreq: NSNumber
    @NSManaged var lfotype: NSNumber
    @NSManaged var master: NSNumber
    @NSManaged var name: String
    @NSManaged var rel: NSNumber
    @NSManaged var reso: NSNumber
    @NSManaged var sus: NSNumber
    @NSManaged var tuning: NSNumber

}
