//
//  EditGasStationViewController.h
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GasStation.h"

@interface EditGasStationViewController : UIViewController 
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *distributorSegmentedControl;
@property (strong, nonatomic) IBOutlet MKMapView *addressMap;
@property (nonatomic, strong) GasStation *gasStation;
- (IBAction)save:(id)sender;

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
@end
