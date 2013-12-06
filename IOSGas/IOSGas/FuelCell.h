//
//  FuelCell.h
//  IOSGas
//
//  Created by Judah Holanda on 12/6/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *gasStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelTypeLabel;

@end   
