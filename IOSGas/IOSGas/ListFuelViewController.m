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

@implementation ListFuelViewController

@synthesize table, fuelPrices; //.m

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
	fuelPrices =[[NSMutableArray alloc] initWithArray: [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error]];
    
    for (int i=0; i<[fuelPrices count]; i++) {
        FuelPrice *tempFuelPrice = [fuelPrices objectAtIndex:i];
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
    //[self.table registerClass:[FuelCell class] forCellReuseIdentifier:@"FuelCell"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return fuelPrices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FuelPrice *fuelPrice = [fuelPrices objectAtIndex:indexPath.row];
	
    FuelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FuelCell"];
    
    if(cell ==nil){
        cell = [[FuelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FuelCell"];
    }
    
	
	cell.priceLabel.text = [NSString stringWithFormat:@"%.2f", [fuelPrice.price doubleValue]];//@"%f",[fuelPrice.price doubleValue];
    
    cell.gasStationLabel.text = fuelPrice.fuel.gasStation.name;
    switch ([fuelPrice.fuel.type.type integerValue]) {
        case 1:
            cell.fuelTypeLabel.text=@"A";
            cell.fuelTypeLabel.textColor=[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
            break;
        
        case 2:
            cell.fuelTypeLabel.text=@"D";
            cell.fuelTypeLabel.textColor=[UIColor colorWithRed:70.0/255.0 green:116.0/255.0 blue:8.0/255.0 alpha:1.0];
            break;
            
        default:
            cell.fuelTypeLabel.text=@"G";
            cell.fuelTypeLabel.textColor=[UIColor redColor];
            break;
    }
//    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Aviso!"
//                                                     message:@"Sem acesso ao servidor, por gentileza consulte o baitinga do suporte"
//                                                  delegate:self
//                                         cancelButtonTitle:@"OK"
//                                         otherButtonTitles:nil, nil];
//  [alerta show];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"goToFuelInformation"]) {
		UITableViewCell *cell = sender;
		NSIndexPath *indexPath = [self.table indexPathForCell:cell];
		
		FuelPrice *fuelprice = [fuelPrices objectAtIndex:indexPath.row];
		
		FuelViewController *ctrl = segue.destinationViewController;
		ctrl.fuelPrice = fuelprice;
	}
}

@end
