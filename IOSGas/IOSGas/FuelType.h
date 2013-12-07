//
//  FuelType.h
//  IOSGas
//
//  Created by Judah Holanda on 12/6/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fuel;

@interface FuelType : NSManagedObject

@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) Fuel *fuel;

@end
