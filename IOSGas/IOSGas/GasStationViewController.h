//
//  GasStationViewController.h
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GasStation.h"

@interface GasStationViewController : UIViewController

@property (nonatomic, strong) GasStation *gasStation;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distributorLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet MKMapView *map;
//-(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressString;
@end
