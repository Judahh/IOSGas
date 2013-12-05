//
//  ADSAuthorEditViewController.h
//  BooksMobile
//
//  Created by Glauco Aquino on 30/11/13.
//  Copyright (c) 2013 UNIFOR. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ADSAuthor.h"

@interface ADSAuthorEditViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *authorIdTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property ADSAuthor *author;

@end
