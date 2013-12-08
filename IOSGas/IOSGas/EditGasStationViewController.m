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
    }else{
        NSMutableSet *gasStations = [[NSMutableSet alloc] initWithSet:_gasStation.distributor.gasStation];
        NSArray *gasStationArray = [gasStations allObjects];
        for (int i=0; i<[gasStationArray count]; i++) {
            GasStation *gasStationTemp=[gasStationArray objectAtIndex:i];
            if(gasStationTemp.name==_gasStation.name){
                [gasStations removeObject:gasStationTemp];
            }else{
                gasStationTemp=nil;
            }
        }
    }
	
	_gasStation.name = _nameTextField.text;
    _gasStation.address = _addressTextField.text;
    
    NSFetchRequest *request = [[ADSAppDelegate sharedAppDelegate].managedObjectModel fetchRequestTemplateForName:@"FetchRequestForAllDistributors"];
	
	NSError *error = nil;
	NSArray *distributors = [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error];
    
    Distributor *distributor;
    
    for (int i=0; i<[distributors count]; i++) {
        distributor=[distributors objectAtIndex:i];
        
        NSLog(@"Distributor Name:%@",distributor.name);
        
        if(distributor.name==[_distributorSegmentedControl titleForSegmentAtIndex:[_distributorSegmentedControl selectedSegmentIndex]]){
            i=[distributors count];
        }else{
            distributor=nil;
        }
    }
    
    if (distributor == nil){
		distributor = [NSEntityDescription insertNewObjectForEntityForName:@"Distributor" inManagedObjectContext:context];
        
        distributor.name = [_distributorSegmentedControl titleForSegmentAtIndex:[_distributorSegmentedControl selectedSegmentIndex]];
    }
    
    NSMutableSet *tempDistibutorGasStation = [[NSMutableSet alloc] initWithSet:distributor.gasStation];
    
    [tempDistibutorGasStation addObject:_gasStation];
    
    distributor.gasStation = tempDistibutorGasStation;
    
    _gasStation.distributor = distributor;
    
    
    
    NSLog(@"Name:%@",_gasStation.name);
    
    NSLog(@"Address:%@",_gasStation.address);
    
    NSLog(@"Distributor:%@",_gasStation.distributor.name);
    
	[context save:NULL];
	
	[self.navigationController popViewControllerAnimated:YES];

}
@end
