//
//  EditGasStationViewController.m
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//
#import "Distributor.h"
#import "EditGasStationViewController.h"
#import "ADSAppDelegate.h"

@interface EditGasStationViewController ()

@end

@implementation EditGasStationViewController

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
    if(_gasStation == nil){
        self.title= @"New Gas Station";
    }else{
        self.title= @"Edit Gas Station";
    }
    _nameTextField.text = _gasStation.name;
    _addressTextField.text = _gasStation.address;
    //_distributorSegmentedControl.selectedSegmentIndex= _gasStation.distributor.name;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [ADSAppDelegate sharedAppDelegate].managedObjectContext;
	
	if (_gasStation == nil){
		_gasStation = [NSEntityDescription insertNewObjectForEntityForName:@"GasStation" inManagedObjectContext:context];
    }
	
	_gasStation.name = _nameTextField.text;
    _gasStation.address = _addressTextField.text;
    //_distributorSegmentedControl.selectedSegmentIndex= _gasStation.distributor.name;
    
	[context save:NULL];
	
	[self.navigationController popViewControllerAnimated:YES];

}
@end
