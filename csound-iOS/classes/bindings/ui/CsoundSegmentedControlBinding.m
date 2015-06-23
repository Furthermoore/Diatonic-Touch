//
//  CsoundSegmentedControlBinding.m
//  DiatonicTouch
//
//  Created by Dan Moore on 6/23/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

#import "CsoundSegmentedControlBinding.h"

@interface CsoundSegmentedControlBinding() {
    float channelValue;
    float *channelPtr;
}
@property (unsafe_unretained) NSString *channelName;
@property (unsafe_unretained) UISegmentedControl *uiSegControl;

@end

@implementation CsoundSegmentedControlBinding

-(instancetype)initSegmentedControl:(UISegmentedControl *)uiSegControl channelName:(NSString *)channelName
{
    if (self = [super init]) {
        self.uiSegControl = uiSegControl;
        self.channelName = channelName;
    }
    return self;
}

-(void)updateChannelValue:(id)sender {
    channelValue = ((UISegmentedControl *)sender).selectedSegmentIndex;
}

-(void)setup:(CsoundObj *)csoundObj
{
    channelValue = self.uiSegControl.selectedSegmentIndex;
    channelPtr = [csoundObj getInputChannelPtr:self.channelName
                                   channelType:CSOUND_CONTROL_CHANNEL];
    [self.uiSegControl addTarget:self
                      action:@selector(updateChannelValue:)
            forControlEvents:UIControlEventValueChanged];
}


-(void)updateValuesToCsound {
    *channelPtr = channelValue;
}

-(void)cleanup {
    [self.uiSegControl removeTarget:self
                         action:@selector(updateChannelValue:)
               forControlEvents:UIControlEventValueChanged];
}

@end
