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

@interface ListGasStationViewController ()

@end

@implementation ListGasStationViewController{
	NSArray *_gasStations;
}

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
	_gasStations = [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error];
	
	[self.table reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Gas Station";
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
	return _gasStations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	GasStation *gasStation = [_gasStations objectAtIndex:indexPath.row];
	
    GasStationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DEFAULT" forIndexPath:indexPath];
	
	cell.nameLabel.text = gasStation.name;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"goToGasStationInformation"]) {
		UITableViewCell *cell = sender;
		NSIndexPath *indexPath = [self.table indexPathForCell:cell];
		
		GasStation *gasStation = [_gasStations objectAtIndex:indexPath.row];
		
		GasStationViewController *ctrl = segue.destinationViewController;
		ctrl.gasStation = gasStation;
	}
}
@end
