//
//  DeviceInfoTestViewController.h
//  DeviceInfoTest
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANXDeviceInfo.h"

@interface DeviceInfoTestViewController : UIViewController

- (IBAction)getIMEIAction:(id)sender;
- (IBAction)getDeviceInfoAction:(id)sender;
- (IBAction)getDeviceIdentifierAction:(id)sender;

@end
