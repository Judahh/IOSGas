//
//  GasStation.h
//  IOSGas
//
//  Created by Judah Holanda on 12/7/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Distributor, Fuel;

@interface GasStation : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Distributor *distributor;
@property (nonatomic, retain) NSSet *fuel;
@end

@interface GasStation (CoreDataGeneratedAccessors)

- (void)addFuelObject:(Fuel *)value;
- (void)removeFuelObject:(Fuel *)value;
- (void)addFuel:(NSSet *)values;
- (void)removeFuel:(NSSet *)values;

@end
