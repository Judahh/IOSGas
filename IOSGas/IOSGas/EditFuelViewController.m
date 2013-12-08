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
        
        Fuel *tempFuel = [NSEntityDescription insertNewObjectForEntityForName:@"Fuel" inManagedObjectContext:context];
        
        //_fuelPrice = [[FuelPrice alloc] init];
        
        
        tempFuel.price=_fuelPrice;
        
        _fuelPrice.fuel=tempFuel;
    }else{
        NSMutableSet *fuels = [[NSMutableSet alloc] initWithSet:_fuelPrice.fuel.gasStation.fuel];
        
        NSArray *fuelArray = [fuels allObjects];
        
        for (int i=0; i<[fuelArray count]; i++) {
            Fuel *fuelTemp=[fuelArray objectAtIndex:i];
            if(fuelTemp==_fuelPrice.fuel){
                [fuels removeObject:fuelTemp];
            }else{
                fuelTemp=nil;
            }
        }
        
        _fuelPrice.fuel.gasStation.fuel = [[NSSet alloc] initWithSet:fuels];
        
        NSMutableSet *fuelTypes = [[NSMutableSet alloc] initWithSet:_fuelPrice.fuel.type.fuel];
        
        NSArray *fuelTypeArray = [fuelTypes allObjects];
        
        for (int i=0; i<[fuelTypeArray count]; i++) {
            FuelType *fuelTypeTemp=[fuelTypeArray objectAtIndex:i];
            if(fuelTypeTemp==_fuelPrice.fuel.type){
                [fuelTypes removeObject:fuelTypeTemp];
            }else{
                fuelTypeTemp=nil;
            }
        }
        
        _fuelPrice.fuel.type.fuel = [[NSSet alloc] initWithSet:fuelTypes];
    }
	_fuelPrice.price =
    [NSDecimalNumber numberWithDouble:[_price.text doubleValue]];
    
    NSFetchRequest *request = [[ADSAppDelegate sharedAppDelegate].managedObjectModel fetchRequestTemplateForName:@"FetchRequestForAllFuelTypes"];
	
	NSError *error = nil;
	NSArray *fueltypes = [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error];
    
    FuelType *fuelTypeTemp;
    
    for (int i=0; i<[fueltypes count]; i++) {
        fuelTypeTemp=[fueltypes objectAtIndex:i];
        
        NSLog(@"FuelType:%@",fuelTypeTemp.type);
        
        if([fuelTypeTemp.type integerValue]==[_type selectedSegmentIndex]){
            i=[fueltypes count];
        }else{
            fuelTypeTemp=nil;
        }
    }
    
    if (fuelTypeTemp == nil){
		fuelTypeTemp = [NSEntityDescription insertNewObjectForEntityForName:@"FuelType" inManagedObjectContext:context];
        
        fuelTypeTemp.type = [NSNumber numberWithInt:[_type selectedSegmentIndex]];
    }
    
    NSMutableSet *tempFuelTypeFuel = [[NSMutableSet alloc] initWithSet:fuelTypeTemp.fuel];
    
    [tempFuelTypeFuel addObject:_fuelPrice.fuel];
    
    fuelTypeTemp.fuel = tempFuelTypeFuel;
    
    _fuelPrice.fuel.type = fuelTypeTemp;
    
    request = [[ADSAppDelegate sharedAppDelegate].managedObjectModel fetchRequestTemplateForName:@"FetchRequestForAllGasStations"];
	
	error = nil;
	NSArray *gasStations = [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error];
    
    GasStation *gasStationTemp;
    
    for (int i=0; i<[gasStations count]; i++) {
        gasStationTemp=[gasStations objectAtIndex:i];
        
        NSLog(@"GasStation:%@",gasStationTemp.name);
        
        NSInteger number=[self.gasStation selectedRowInComponent:0];
        
        GasStation *tempGasStation = [self.gasStationArray objectAtIndex:number];
        if(gasStationTemp==tempGasStation){
            i=[fueltypes count];
        }else{
            gasStationTemp=nil;
        }
    }
    
    if (gasStationTemp == nil){
		gasStationTemp = [NSEntityDescription insertNewObjectForEntityForName:@"GasStation" inManagedObjectContext:context];
        
        NSInteger number=[self.gasStation selectedRowInComponent:0];
        
        GasStation *tempGasStation = [self.gasStationArray objectAtIndex:number];
        
        gasStationTemp.name = tempGasStation.name;
    }
    
    NSMutableSet *tempGasStationFuel = [[NSMutableSet alloc] initWithSet:gasStationTemp.fuel];
    
    [tempGasStationFuel addObject:_fuelPrice.fuel];
    
    gasStationTemp.fuel = tempGasStationFuel;
    
    _fuelPrice.fuel.gasStation = gasStationTemp;
    
    NSLog(@"Price:%@",_fuelPrice.price);
    
    NSLog(@"Type:%@",_fuelPrice.fuel.type.type);
    
    NSLog(@"GasStation:%@",_fuelPrice.fuel.gasStation.name);
    
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
    return [_gasStationArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    GasStation *tempGasStation = [self.gasStationArray objectAtIndex:row];
    NSLog(@"Selected Row %@", tempGasStation.name);
    return tempGasStation.name;
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
