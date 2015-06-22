//
//  MusicTheory.m
//  csTouch
//
//  Created by Dan Moore on 5/30/15.
//  Copyright (c) 2015 Boulanger Labs. All rights reserved.
//

#import "MusicTheory.h"

@implementation MusicTheory

+(NSArray*)chordScaleForRoot:(NSInteger)root
                    tonality:(NSInteger)tonality
                       steps:(NSInteger)steps
                       range:(NSInteger)range
                      octave:(NSInteger)octave
{
    Note note = (Note)root;
    Tonality color = (Tonality)tonality;
    NSMutableArray *scale = [[NSMutableArray alloc] initWithCapacity:steps*range+1];
    NSNumber *currentNote = [NSNumber numberWithInt:((int)(octave+2) * 12) + (int)note];
    scale[0] = currentNote;
    NSArray *addArray;
    
    switch (steps) {
        case 1:
            addArray = @[@12];
            break;
        case 2:
            addArray = @[@7,@5];
            break;
        case 3:
            if (color == kMajor) {
                addArray = @[@7,@2,@3];
            } else if (color == kMinor) {
                addArray = @[@7,@1,@4];
            }
            break;
        case 4:
            if (color == kMajor) {
                addArray = @[@4,@3,@2,@3];
            } else if (color == kMinor) {
                addArray = @[@3,@4,@1,@4];
            }
            break;
        case 5:
            if (color == kMajor) {
                addArray = @[@2,@2,@3,@2,@3];
            } else if (color == kMinor) {
                addArray = @[@2,@1,@4,@1,@4];
            }
            break;
        case 6:
            if (color == kMajor) {
                addArray = @[@2,@2,@1,@2,@2,@3];
            } else if (color == kMinor) {
                addArray = @[@2,@1,@2,@2,@1,@4];
            }
            break;
        case 7:
            if (color == kMajor) {
                addArray = @[@2,@2,@1,@2,@2,@2,@1];
            } else if (color == kMinor) {
                addArray = @[@2,@1,@2,@2,@1,@2,@2];
            }
            break;
        default:
            break;
    }
    
    if (steps*range+1 > 1) {
        for (int i = 1; i < steps*range+1; i++) {
            currentNote = [NSNumber numberWithInteger:(currentNote.integerValue) + ((NSNumber*)addArray[(i-1)%steps]).integerValue];
            scale[i] = currentNote;
        }
    }
    NSArray *finalScale = [scale copy];
    return finalScale;
}

+(NSString *)MIDIStringForNumber:(NSInteger)noteNum
{
    int octave = (int)noteNum / 12;
    int step = (int)noteNum % 12;
    NSString *note;
    NSString *num;
    switch (octave) {
        case 0:
            note = @"-2";
            break;
        case 1:
            note = @"-1";
            break;
        case 2:
            note = @"0";
            break;
        case 3:
            note = @"1";
            break;
        case 4:
            note = @"2";
            break;
        case 5:
            note = @"3";
            break;
        case 6:
            note = @"4";
            break;
        case 7:
            note = @"5";
            break;
        case 8:
            note = @"6";
            break;
        case 9:
            note = @"7";
            break;
        case 10:
            note = @"8";
            break;
        default:
            note = @"3";
            break;
    }
    switch (step) {
        case 0:
            num = @"C";
            break;
        case 1:
            num = @"Db";
            break;
        case 2:
            num = @"D";
            break;
        case 3:
            num = @"Eb";
            break;
        case 4:
            num = @"E";
            break;
        case 5:
            num = @"F";
            break;
        case 6:
            num = @"Gb";
            break;
        case 7:
            num = @"G";
            break;
        case 8:
            num = @"Ab";
            break;
        case 9:
            num = @"A";
            break;
        case 10:
            num = @"Bb";
            break;
        case 11:
            num = @"B";
            break;
        default:
            num = @"C";
            break;
    }
    
    return [num stringByAppendingString:note];
}

@end
