//
//  CsoundSegmentedControlBinding.h
//  DiatonicTouch
//
//  Created by Dan Moore on 6/23/15.
//  Copyright (c) 2015 FurtherMoore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CsoundObj.h"
#import <UIKit/UIKit.h>

@interface CsoundSegmentedControlBinding : NSObject<CsoundBinding>

-(instancetype)initSegmentedControl:(UISegmentedControl *)uiSegControl channelName:(NSString *)channelName;

@end
