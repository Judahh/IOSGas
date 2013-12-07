//
//  EditPriceViewController.h
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuelPrice.h"

@interface EditFuelViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
@property (weak, nonatomic) IBOutlet UIPickerView *gasStation;
- (IBAction)save:(id)sender;

@property FuelPrice *fuelPrice;
@end
