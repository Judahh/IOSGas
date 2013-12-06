//
//  EditPriceViewController.m
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import "EditFuelViewController.h"
#import "Fuel.h"
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
	if (_fuel != nil) {
		_price.text = [NSString stringWithFormat:@"%@", _fuel.type];
		//_type.selectedSegment = _fuel.type;
        //_gasStation
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    NSManagedObjectContext *context = [ADSAppDelegate sharedAppDelegate].managedObjectContext;
	
	if (_fuel == nil)
		_fuel = [NSEntityDescription insertNewObjectForEntityForName:@"Fuels" inManagedObjectContext:context];
	
	//_fuel.fuelId = [NSNumber numberWithInt:[_fuelIdTextField.text integerValue]];
	
	//_fuel.type = _nameTextField.text;
    
	[context save:NULL];
	
	[self.navigationController popViewControllerAnimated:YES];}

@end
