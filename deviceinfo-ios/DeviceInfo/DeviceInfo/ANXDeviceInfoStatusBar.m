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
    switch ([[UIApplication sharedApplication] statusBarStyle]) {
        case UIStatusBarStyleLightContent:
            return @"light";
        case UIStatusBarStyleDarkContent:
            return @"dark";
        default:
            return @"default";
    }
}

+(void) setStyle: (NSString*) style {
    NSLog(@"ANXDeviceInfoStatusBar setStyle:%@", style);
    if ([style isEqualToString: @"light"]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else if ([style isEqualToString: @"dark"]) {
        if (@available(iOS 13.0, *)) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent];
        } else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

@end
