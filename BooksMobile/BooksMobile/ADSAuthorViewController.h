//
//  ADSAuthorViewController.h
//  BooksMobile
//
//  Created by Glauco Aquino on 30/11/13.
//  Copyright (c) 2013 UNIFOR. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ADSAuthor.h"

@interface ADSAuthorViewController : UIViewController

@property ADSAuthor *author;

@property (weak, nonatomic) IBOutlet UILabel *authorIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
