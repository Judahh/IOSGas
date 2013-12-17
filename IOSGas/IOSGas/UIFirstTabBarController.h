//
//  UIFirstTabBarController.h
//  IOSGas
//
//  Created by Judah Holanda on 12/6/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFirstTabBarController : UITabBarController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *AddButton;
- (IBAction)AddItem:(id)sender;

@end
