//
//  EditPriceViewController.m
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import "EditFuelViewController.h"
#import "Fuel.h"
#import "FuelPrice.h"
#import "FuelType.h"
#import "GasStation.h"
#import "ADSAppDelegate.h"

@interface EditFuelViewController ()

@end

@implementation EditFuelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
	if (_fuelPrice != nil) {
		_price.text = [NSString stringWithFormat:@"%@", _fuelPrice.price];
		//_type.selectedSegment = _fuel.type;
        //_gasStation
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([_price.text isEqual:@""]){
        self.title= @"New Fuel";
    }else{
        self.title= @"Edit Fuel";
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [ADSAppDelegate sharedAppDelegate].managedObjectContext;
	
	if (_fuelPrice == nil){
		_fuelPrice = [NSEntityDescription insertNewObjectForEntityForName:@"FuelPrice" inManagedObjectContext:context];
    }
	
	_fuelPrice.price = [NSDecimalNumber numberWithDouble:[_price.text doubleValue]];
	
	_fuelPrice.fuel.type.type = [NSNumber numberWithInt:[_type selectedSegmentIndex]];
    
    //_fuelPrice.fuel.gasStation.name = [_gasStation selectedRowInComponent:0];
    
	//[context save:NULL];
	
	//[self.navigationController popViewControllerAnimated:YES];
}
@end
