//
//  PriceViewController.m
//  IOSGas
//
//  Created by Tarciso Torres on 12/4/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import "FuelViewController.h"
#import "Fuel.h"
#import "GasStation.h"

@interface FuelViewController ()

@end

@implementation FuelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// self.title = @"Fuel";
    _priceLabel.text = [_fuelPrice.price stringValue];
    _gasStationLabel.text = _fuelPrice.fuel.gasStation.name;
    _addressLabel.text = _fuelPrice.fuel.gasStation.address;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
