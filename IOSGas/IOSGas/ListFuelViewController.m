//
//  ListPriceViewController.m
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import "Fuel.h"
#import "FuelPrice.h"
#import "FuelType.h"
#import "FuelCell.h"
#import "GasStation.h"
#import "ADSAppDelegate.h"
#import "FuelViewController.h"
#import "ListFuelViewController.h"

@interface ListFuelViewController ()

@end

@implementation ListFuelViewController{
	NSArray *_fuelPrices;
}

@synthesize table; //.m

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
    NSFetchRequest *request = [[ADSAppDelegate sharedAppDelegate].managedObjectModel fetchRequestTemplateForName:@"FetchRequestForAllFuelPrices"];
	
	NSError *error = nil;
	_fuelPrices = [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error];
    
    for (int i=0; i<[_fuelPrices count]; i++) {
        FuelPrice *tempFuelPrice = [_fuelPrices objectAtIndex:i];
        NSLog(@"Price=%@",tempFuelPrice.price);
        NSLog(@"Type=%@",tempFuelPrice.fuel.type.type);
        NSLog(@"GasStation=%@",tempFuelPrice.fuel.gasStation.name);
    }
    
	[self.table reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Fuel";
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.table registerClass:[FuelCell class] forCellReuseIdentifier:@"FuelCell"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _fuelPrices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FuelPrice *fuelPrice = [_fuelPrices objectAtIndex:indexPath.row];
	
    FuelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FuelCell" forIndexPath:indexPath];
	
	cell.priceLabel.text = [fuelPrice.price stringValue];
    cell.gasStationLabel.text = fuelPrice.fuel.gasStation.name;
    switch ([fuelPrice.fuel.type.type integerValue]) {
        case 1:
            cell.fuelTypeLabel.text=@"A";
            cell.fuelTypeLabel.textColor=[UIColor blueColor];
            break;
        
        case 2:
            cell.fuelTypeLabel.text=@"D";
            cell.fuelTypeLabel.textColor=[UIColor greenColor];
            break;
            
        default:
            cell.fuelTypeLabel.text=@"G";
            cell.fuelTypeLabel.textColor=[UIColor redColor];
            break;
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"goToFuelInformation"]) {
		UITableViewCell *cell = sender;
		NSIndexPath *indexPath = [self.table indexPathForCell:cell];
		
		FuelPrice *fuelprice = [_fuelPrices objectAtIndex:indexPath.row];
		
		FuelViewController *ctrl = segue.destinationViewController;
		ctrl.fuelPrice = fuelprice;
	}
}

@end
