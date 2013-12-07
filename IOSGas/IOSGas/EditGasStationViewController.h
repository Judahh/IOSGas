//
//  EditGasStationViewController.h
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EditGasStationViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *distributorSegmentedControl;
@property (weak, nonatomic) IBOutlet MKMapView *addressMap;

@end
