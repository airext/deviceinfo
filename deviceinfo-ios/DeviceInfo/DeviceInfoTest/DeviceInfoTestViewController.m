//
//  DeviceInfoTestViewController.m
//  DeviceInfoTest
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "DeviceInfoTestViewController.h"

@interface DeviceInfoTestViewController ()

@end

@implementation DeviceInfoTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getIMEIAction:(id)sender
{
    NSLog(@"IMEI: %@", [[ANXDeviceInfo sharedInstance] getIMEI]);
}

- (IBAction)getDeviceInfoAction:(id)sender
{
    NSDictionary* info = [[ANXDeviceInfo sharedInstance] getDeviceInfo];
    
    NSLog(@"%@", info);
}

- (IBAction)getDeviceIdentifierAction:(id)sender
{
    NSString* id = [[ANXDeviceInfo sharedInstance] getDeviceIdentifier];
    
    NSLog(@"%@", id);
}
@end
