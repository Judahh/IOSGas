//
//  ListGasStationViewController.m
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import "ListGasStationViewController.h"
#import "GasStation.h"
#import "GasStationCell.h"
#import "GasStationViewController.h"
#import "ADSAppDelegate.h"
#import "Distributor.h"

@interface ListGasStationViewController ()

@end

@implementation ListGasStationViewController

@synthesize table, gasStations, searchResult; //.m

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
	
    NSFetchRequest *request = [[ADSAppDelegate sharedAppDelegate].managedObjectModel fetchRequestTemplateForName:@"FetchRequestForAllGasStations"];
	
	NSError *error = nil;
	gasStations =[[NSMutableArray alloc] initWithArray:  [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error]];
	
    for (int i=0; i<[gasStations count]; i++) {
        GasStation *tempGasStation = [gasStations objectAtIndex:i];
        NSLog(@"GAS=%@",tempGasStation.name);
    }
    
    
    
	[self.table reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Gas Station";
    [self.navigationController setNavigationBarHidden:NO];
    [self.table reloadData];
    self.table.dataSource = self;
    self.table.delegate = self;
    //[self.table registerClass:[GasStationCell class] forCellReuseIdentifier:@"GasStationCell"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterContentForSearchText: (NSString *) searchText
{
    NSArray *temp = [[NSArray alloc] initWithArray:self.gasStations];
    //NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchText];
    
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    self.searchResult = [[NSArray alloc] init];
    
    for (int index=0; index<temp.count; index++) {
        NSString *name = [[temp objectAtIndex:index] name];
        NSString *name2 = [[[temp objectAtIndex:index] distributor] name];
        if (([name.lowercaseString rangeOfString:searchText.lowercaseString].location!=NSNotFound)||
            ([name2.lowercaseString rangeOfString:searchText.lowercaseString].location!=NSNotFound)) {
            [searchArray addObject:name];
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
        return gasStations.count;
    } else {
        return  searchResult.count;
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GasStationCell";
    GasStationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell ==nil){
        cell = [[GasStationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSLog(@"Cell=Null");
	}
    NSLog(@"TESTE B");
    if (tableView == self.table) {
        
        NSLog(@"TESTE Z");
        GasStation *gasStation = [gasStations objectAtIndex:indexPath.row];
        
        cell.nameLabel.text = gasStation.name;
        cell.distributorLabel.text =gasStation.distributor.name;
        NSLog(@"GASNAME=%@",gasStation.name);
        //[cell reloadInputViews];
        NSLog(@"GASLabel=%@",cell.nameLabel.text);
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"ID: %@", currentContext.ID];
        
    } else {
        NSLog(@"TESTE K");
        
        for (int index=0; index < gasStations.count; index++) {
            
            NSLog(@"TESTE K1");
            GasStation *gasStation = [gasStations objectAtIndex:index];
            NSLog(@"TESTE K3");
            NSString *gasStationResult = [self.searchResult objectAtIndex:indexPath.row];
            NSLog(@"TESTE K4");
            if([gasStation.name isEqualToString:gasStationResult]){
                cell.textLabel.text = gasStationResult;
                cell.distributorLabel.text =gasStation.distributor.name;
                NSLog(@"TESTE K5");
                return cell;
            }
        }
    }
    NSLog(@"TESTE C"); 
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"goToGasStationInformation"]) {
		UITableViewCell *cell = sender;
		NSIndexPath *indexPath = [self.table indexPathForCell:cell];
		
		GasStation *gasStation = [gasStations objectAtIndex:indexPath.row];
		
		GasStationViewController *ctrl = segue.destinationViewController;
		ctrl.gasStation = gasStation;
	}
}
@end
