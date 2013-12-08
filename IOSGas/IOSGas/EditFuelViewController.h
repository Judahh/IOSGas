//
//  EditPriceViewController.h
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuelPrice.h"

@interface EditFuelViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
//@property (strong, nonatomic) IBOutlet UIPickerView *gasStation;
@property (strong, nonatomic) IBOutlet UIPickerView *gasStation;
@property (strong, nonatomic) NSArray *gasStationArray;

- (IBAction)save:(id)sender;

@property FuelPrice *fuelPrice;
@end
