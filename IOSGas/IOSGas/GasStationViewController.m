//
//  GasStationViewController.m
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import "GasStationViewController.h"
#import "Distributor.h"

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
    _map.camera.
	// Do any additional setup after loading the view.
}

-(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressString {
    if (!addressString.length) {
        //ALog(@"provided an empty 'addressStr'");
        return CLLocationCoordinate2DMake(0.0, 0.0);
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv",
                        [addressString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *dataError;
    NSError *jsonError;
    NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]
                                                 options:NSDataReadingMappedAlways
                                                   error:&dataError];
    NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
    
    if (!dataError && !jsonError && [responseBody[@"status"] isEqualToString:@"OK"]) {
        NSDictionary *coords = responseBody[@"results"][0][@"geometry"][@"location"];
        return CLLocationCoordinate2DMake([coords[@"lat"] doubleValue],
                                          [coords[@"lng"] doubleValue]);
    }
    else {
        //ALog(@"Address [%@] not found. \nResponse [%@]. \nError [%@]",addressString, responseBody, jsonError);
        return CLLocationCoordinate2DMake(0.0, 0.0);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
