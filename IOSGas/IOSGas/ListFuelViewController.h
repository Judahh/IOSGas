//
//  ListPriceViewController.h
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListFuelViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *fuelPrices;
@end
