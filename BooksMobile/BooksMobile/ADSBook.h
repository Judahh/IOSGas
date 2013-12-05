//
//  ADSBook.h
//  BooksMobile
//
//  Created by Glauco Aquino on 30/11/13.
//  Copyright (c) 2013 UNIFOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ADSAuthor;

@interface ADSBook : NSManagedObject

@property (nonatomic, retain) NSNumber * bookId;
@property (nonatomic, retain) NSData * cover;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) ADSAuthor *author;

@end
