//
//  PriceViewController.h
//  IOSGas
//
//  Created by Tarciso Torres on 12/4/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuelPrice.h"

@interface FuelViewController : UIViewController

@property (nonatomic, strong) FuelPrice *fuelPrice;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *gasStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
