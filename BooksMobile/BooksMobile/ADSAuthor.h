//
//  ADSAuthor.h
//  BooksMobile
//
//  Created by Glauco Aquino on 30/11/13.
//  Copyright (c) 2013 UNIFOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ADSBook;

@interface ADSAuthor : NSManagedObject

@property (nonatomic, retain) NSNumber * authorId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *books;
@end

@interface ADSAuthor (CoreDataGeneratedAccessors)

- (void)addBooksObject:(ADSBook *)value;
- (void)removeBooksObject:(ADSBook *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end
