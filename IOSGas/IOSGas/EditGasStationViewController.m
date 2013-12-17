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

@synthesize nameTextField, addressMap, addressTextField, distributorSegmentedControl, gasStation;

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
    if(gasStation == nil){
        self.title= @"New Gas Station";
    }else{
        self.title= @"Edit Gas Station";
    }
    nameTextField.text = gasStation.name;
    addressTextField.text = gasStation.address;
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
	
	if (gasStation == nil){
		gasStation = [NSEntityDescription insertNewObjectForEntityForName:@"GasStation" inManagedObjectContext:context];
    }else{
        NSMutableSet *gasStations = [[NSMutableSet alloc] initWithSet:gasStation.distributor.gasStation];
        
        NSArray *gasStationArray = [gasStations allObjects];
        
        for (int i=0; i<[gasStationArray count]; i++) {
            GasStation *gasStationTemp=[gasStationArray objectAtIndex:i];
            if(gasStationTemp==gasStation){
                [gasStations removeObject:gasStationTemp];
            }else{
                gasStationTemp=nil;
            }
        }
        
        gasStation.distributor.gasStation = [[NSSet alloc] initWithSet:gasStations];

    }
	
	gasStation.name = nameTextField.text;
    gasStation.address = addressTextField.text;
    
    NSFetchRequest *request = [[ADSAppDelegate sharedAppDelegate].managedObjectModel fetchRequestTemplateForName:@"FetchRequestForAllDistributors"];
	
	NSError *error = nil;
	NSArray *distributors = [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error];
    
    Distributor *distributor;
    
    for (int i=0; i<[distributors count]; i++) {
        distributor=[distributors objectAtIndex:i];
        
        NSLog(@"Distributor Name:%@",distributor.name);
        
        if(distributor.name==[distributorSegmentedControl titleForSegmentAtIndex:[distributorSegmentedControl selectedSegmentIndex]]){
            i=[distributors count];
        }else{
            distributor=nil;
        }
    }
    
    if (distributor == nil){
		distributor = [NSEntityDescription insertNewObjectForEntityForName:@"Distributor" inManagedObjectContext:context];
        
        distributor.name = [distributorSegmentedControl titleForSegmentAtIndex:[distributorSegmentedControl selectedSegmentIndex]];
    }
    
    NSMutableSet *tempDistibutorGasStation = [[NSMutableSet alloc] initWithSet:distributor.gasStation];
    
    [tempDistibutorGasStation addObject:gasStation];
    
    distributor.gasStation = tempDistibutorGasStation;
    
    gasStation.distributor = distributor;
    
    
    
    NSLog(@"Name:%@",gasStation.name);
    
    NSLog(@"Address:%@",gasStation.address);
    
    NSLog(@"Distributor:%@",gasStation.distributor.name);
    
	[context save:NULL];
	
	[self.navigationController popViewControllerAnimated:YES];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == nameTextField){
        [addressTextField becomeFirstResponder];
        return  YES;
    }else if (textField == addressTextField){
        [nameTextField resignFirstResponder];
        return YES;
    }
    return NO;
}
@end
