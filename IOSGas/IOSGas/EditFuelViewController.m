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



@interface EditFuelViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation EditFuelViewController

@synthesize gasStation; //.m

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
    
    NSFetchRequest *request = [[ADSAppDelegate sharedAppDelegate].managedObjectModel fetchRequestTemplateForName:@"FetchRequestForAllGasStations"];
	
	NSError *error = nil;
    
    gasStation.delegate = self;
    gasStation.dataSource = self;
    
    //self.gasStationArray  = [[NSArray alloc]         initWithObjects:@"Blue",@"Green",@"Orange",@"Purple",@"Red",@"Yellow" , nil];
    
	_gasStationArray = [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error];
    
    if(_fuelPrice == nil){
        self.title= @"New Fuel";
    }else{
        self.title= @"Edit Fuel";
    }
    _price.text = [_fuelPrice.price stringValue];
    //_type.selectedSegmentIndex = _fuelPrice.fuel.type.type;
    //[_gasStation selectedRowInComponent:0]= _fuelPrice.fuel.gasStation.name;
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
	
	//_fuelPrice.price = [NSDecimalNumber numberWithDouble:[_price.text doubleValue]];
	
	_fuelPrice.fuel.type.type = [NSNumber numberWithInt:[_type selectedSegmentIndex]];
    
    //_fuelPrice.fuel.gasStation.name = [_gasStation selectedRowInComponent:0];
    
	[context save:NULL];
	
	[self.navigationController popViewControllerAnimated:YES];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 6;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    NSLog(@"Selected Row %@", [self.gasStationArray objectAtIndex:row]);
    return [self.gasStationArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    
    NSLog(@"Selected Row %d", row);
    switch(row)
    {
            
        case 0:
            //self.color.text = @"Blue #0000FF";
            //self.color.textColor = [UIColor colorWithRed:0.0f/255.0f green: 0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 1:
            //self.color.text = @"Green #00FF00";
            //self.color.textColor = [UIColor colorWithRed:0.0f/255.0f green: 255.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 2:
            //self.color.text = @"Orange #FF681F";
            //self.color.textColor = [UIColor colorWithRed:205.0f/255.0f green:   140.0f/255.0f blue:31.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 3:
            //self.color.text = @"Purple #FF00FF";
            //self.color.textColor = [UIColor colorWithRed:255.0f/255.0f green:   0.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 4:
            //self.color.text = @"Red #FF0000";
            //self.color.textColor = [UIColor colorWithRed:255.0f/255.0f green:   0.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            break;
        case 5:
            //self.color.text = @"Yellow #FFFF00";
            //self.color.textColor = [UIColor colorWithRed:255.0f/255.0f green:   255.0f/255.0f blue:0.0f/255.0f alpha:255.0f/255.0f];
            break;
    }
    
}


@end
