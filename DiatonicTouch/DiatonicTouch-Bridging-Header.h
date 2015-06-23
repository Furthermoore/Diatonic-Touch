//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "MusicTheory.h" // used in DiatonicKeyboardView

#import "CsoundObj.h"   // used in InstrumentViewController
                        // I have modified CsoundObj.m
                        // implemented the csound console message callback - now feeds to Xcode console with NSLog
                        // should be used in production only. see init method.

#import "CsoundUI.h"    // used in InstrumentViewController - some extra api for easily attaching Cocoa UI to Csound
                        