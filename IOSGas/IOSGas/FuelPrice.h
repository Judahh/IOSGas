//
//  FuelPrice.h
//  IOSGas
//
//  Created by Judah Holanda on 12/7/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fuel;

@interface FuelPrice : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) Fuel *fuel;

@end
