//
//  ADSBook+UISupport.m
//  BooksMobile
//
//  Created by Glauco Aquino on 30/11/13.
//  Copyright (c) 2013 UNIFOR. All rights reserved.
//

#import "ADSBook+UISupport.h"

@implementation ADSBook (UISupport)
-(UIImage *)coverImage {
	return [UIImage imageWithData:self.cover];
}
@end
