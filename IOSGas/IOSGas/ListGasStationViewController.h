//
//  ListGasStationViewController.h
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListGasStationViewController : UIViewController< UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *gasStations;
@property (strong, nonatomic) NSArray *searchResult;
@end
