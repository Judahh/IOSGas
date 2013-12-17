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
#import "EditFuelViewController.h"

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
    _priceLabel.text = [NSString stringWithFormat:@"%.2f", [_fuelPrice.price doubleValue]];
    //@"%f",    _priceLabel.text = [_fuelPrice.price stringValue];
    _gasStationLabel.text = _fuelPrice.fuel.gasStation.name;
    _addressLabel.text = _fuelPrice.fuel.gasStation.address;
    //    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Aviso!"
    //                                                     message:@"Campos incompletos"
    //                                                  delegate:self
    //                                         cancelButtonTitle:@"OK"
    //                                         otherButtonTitles:nil, nil];
    //  [alerta show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"goToEditFuel"]) {
		EditFuelViewController *ctrl = segue.destinationViewController;
		ctrl.fuelPrice = _fuelPrice;
	}
}

@end
