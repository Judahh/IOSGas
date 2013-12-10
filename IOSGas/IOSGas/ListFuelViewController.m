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

@synthesize table, fuelPrices, searchResult; //.m

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

- (void)filterContentForSearchText: (NSString *) searchText
{
    NSArray *temp = [[NSArray alloc] initWithArray:self.fuelPrices];
    //NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchText];
    
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    self.searchResult = [[NSArray alloc] init];
    
    for (int index=0; index<temp.count; index++) {
        NSString *name = [[[[temp objectAtIndex:index] fuel] gasStation] name];
        NSDecimalNumber *price = [[temp objectAtIndex:index] price];
        NSNumber *fuel = [[[[temp objectAtIndex:index] fuel] type] type];
        
        NSLog(@"Name=%@",name);
        NSLog(@"Price=%@",price);
        NSLog(@"Fuel=%@",fuel);
        
        if (([name.lowercaseString rangeOfString:searchText.lowercaseString].location!=NSNotFound)) {
            [searchArray addObject:[temp objectAtIndex:index]];
        }
        
        switch ([fuel integerValue]) {
            case 1:
                if([searchText.lowercaseString isEqualToString:@"diesel"]){
                    [searchArray addObject:[temp objectAtIndex:index]];
                }
                break;
                
            case 2:
                if([searchText.lowercaseString isEqualToString:@"alcohol"]){
                    [searchArray addObject:[temp objectAtIndex:index]];
                }
                break;
                
            default:
                if([searchText.lowercaseString isEqualToString:@"gasoline"]||[searchText.lowercaseString isEqualToString:@"gas"]){
                    [searchArray addObject:[temp objectAtIndex:index]];
                }
                break;
        }
        
        NSDecimalNumber *value=[NSDecimalNumber numberWithDouble:[searchText doubleValue]];
        if ([value floatValue]>0) {
            if ([value floatValue]>=[price floatValue]) {
                [searchArray addObject:[temp objectAtIndex:index]];
            }
        }
    }
    
    NSLog(@"TESTE A");
    
    self.searchResult = searchArray;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.table) {
        return fuelPrices.count;
    } else {
        return  searchResult.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FuelPrice *fuelPrice = [fuelPrices objectAtIndex:indexPath.row];
	
    FuelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FuelCell"];
    
    if(cell ==nil){
        cell = [[FuelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FuelCell"];
    }
    
    if (tableView == self.table) {
	
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
    
    } else {
        NSLog(@"TESTE K");
        
        for (int index=0; index < fuelPrices.count; index++) {
            NSLog(@"TESTE K1");
            FuelPrice *fuelPrice = [fuelPrices objectAtIndex:index];
            NSLog(@"TESTE K3");
            FuelPrice *fuelPriceResult = [self.searchResult objectAtIndex:indexPath.row];
            NSLog(@"TESTE K4");
            
            if(fuelPrice == fuelPriceResult){
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
                
                NSLog(@"NORMAL Name=%@",fuelPrice.fuel.gasStation.name);
                NSLog(@"NORMAL Price=%@",[NSString stringWithFormat:@"%.2f", [fuelPrice.price doubleValue]]);
                NSLog(@"NORMAL Fuel=%@",fuelPrice.fuel.type.type);
                
                NSLog(@"Name=%@",cell.gasStationLabel.text);
                NSLog(@"Price=%@",cell.priceLabel.text);
                NSLog(@"Fuel=%@",cell.fuelTypeLabel.text);
                
                NSLog(@"TESTE K5");
                
                return cell;
            }
        }
    }

    
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
