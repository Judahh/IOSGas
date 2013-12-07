//
//  GasStationViewController.m
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import "GasStationViewController.h"
#import "Distributor.h"
#import "EditGasStationViewController.h"
//#import <NSString+SBJSON.h>

@interface GasStationViewController ()

@end

@implementation GasStationViewController

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
    _nameLabel.text = _gasStation.name;
    _distributorLabel.text = _gasStation.distributor.name;
    _addressLabel.text = _gasStation.address;
    //_map.centerCoordinate = [getLocationFromAddressString :_gasStation.address ];
	// Do any additional setup after loading the view.
}

//-(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressString {
    //double latitude = 0.0;
    //double longitude = 0.0;
        
    //NSString *esc_addr =  [addressString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
        
    //NSDictionary *googleResponse = [[NSString stringWithContentsOfURL: [NSURL URLWithString: req] encoding: NSUTF8StringEncoding error: NULL] JSONValue];
        
    //NSDictionary    *resultsDict = [googleResponse valueForKey:  @"results"];   // get the results dictionary
    //NSDictionary   *geometryDict = [resultsDict valueForKey: @"geometry"];   // geometry dictionary within the  results dictionary
    //NSDictionary   *locationDict = [geometryDict valueForKey: @"location"];   // location dictionary within the geometry dictionary
        
    //NSArray *latArray = [locationDict valueForKey: @"lat"];
    //NSString *latString = [latArray lastObject];     // (one element) array entries provided by the json parser
        
    //NSArray *lngArray = [locationDict valueForKey: @"lng"];
    //NSString *lngString = [lngArray lastObject];     // (one element) array entries provided by the json parser
        
    //CLLocationCoordinate2D location;
    //location.latitude = [latString doubleValue];// latitude;
    //location.longitude = [lngString doubleValue]; //longitude;
    
    //return location;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"goToEditGasStation"]) {
		EditGasStationViewController *ctrl = segue.destinationViewController;
		ctrl.gasStation = _gasStation;
	}
}
@end
