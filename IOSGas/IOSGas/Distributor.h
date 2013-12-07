//
//  Distributor.h
//  IOSGas
//
//  Created by Judah Holanda on 12/7/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GasStation;

@interface Distributor : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *gasStation;
@end

@interface Distributor (CoreDataGeneratedAccessors)

- (void)addGasStationObject:(GasStation *)value;
- (void)removeGasStationObject:(GasStation *)value;
- (void)addGasStation:(NSSet *)values;
- (void)removeGasStation:(NSSet *)values;

@end
