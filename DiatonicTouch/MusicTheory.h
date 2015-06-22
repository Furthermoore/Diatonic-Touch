//
//  MusicTheory.h
//  csTouch
//
//  Created by Dan Moore on 5/30/15.
//  Copyright (c) 2015 Boulanger Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kC = 0,
    kDb,
    kD,
    kEb,
    kE,
    kF,
    kGb,
    kG,
    kAb,
    kA,
    kBb,
    kB
} Note;

typedef enum {
    kMajor = 0,
    kMinor
} Tonality;

@interface MusicTheory : NSObject

+(NSArray*)chordScaleForRoot:(NSInteger)root // A = 0 to Ab = 11
                    tonality:(NSInteger)tonality // major or minor, 0 or 1
                       steps:(NSInteger)steps // to next octave
                       range:(NSInteger)range // in octaves
                      octave:(NSInteger)octave; // expect value between -2 and 8

+(NSString *)MIDIStringForNumber:(NSInteger)noteNum;

@end
