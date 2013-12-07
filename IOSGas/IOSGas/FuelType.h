//
//  FuelType.h
//  IOSGas
//
//  Created by Judah Holanda on 12/7/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fuel;

@interface FuelType : NSManagedObject

@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *fuel;
@end

@interface FuelType (CoreDataGeneratedAccessors)

- (void)addFuelObject:(Fuel *)value;
- (void)removeFuelObject:(Fuel *)value;
- (void)addFuel:(NSSet *)values;
- (void)removeFuel:(NSSet *)values;

@end
