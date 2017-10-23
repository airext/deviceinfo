//
//  ANXDeviceInfoStatusBar.m
//  Swizzling
//
//  Created by Max Rozdobudko on 3/22/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import "ANXDeviceInfoStatusBar.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static BOOL ANXDeviceInfoStatusBarIsHidden = YES;
static NSString* ANXDeviceInfoStatusBarStyle;
static NSString* ANXDeviceInfoStatusBarAnimation;

@implementation ANXDeviceInfoStatusBar

+(NSString*) getStyle {
    if ([[UIApplication sharedApplication] statusBarStyle] == UIStatusBarStyleLightContent) {
        return @"light";
    } else {
        return @"default";
    }
}

+(void) setStyle: (NSString*) style {
    NSLog(@"ANXDeviceInfoStatusBar setStyle:%@", style);
    if ([style isEqualToString: @"light"]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

@end
