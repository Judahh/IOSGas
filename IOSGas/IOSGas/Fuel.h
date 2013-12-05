//
//  Fuel.h
//  IOSGas
//
//  Created by Judah Holanda on 12/5/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fuel : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * subType;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSManagedObject *gasStation;

@end
