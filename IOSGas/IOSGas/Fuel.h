//
//  Fuel.h
//  IOSGas
//
//  Created by Judah Holanda on 12/6/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FuelPrice, FuelType, GasStation;

@interface Fuel : NSManagedObject

@property (nonatomic, retain) GasStation *gasStation;
@property (nonatomic, retain) FuelType *type;
@property (nonatomic, retain) FuelPrice *price;

@end
