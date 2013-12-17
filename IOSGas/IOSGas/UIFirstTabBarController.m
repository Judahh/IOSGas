//
//  UIFirstTabBarController.m
//  IOSGas
//
//  Created by Judah Holanda on 12/6/13.
//  Copyright (c) 2013 Judah Holanda. All rights reserved.
//

#import "UIFirstTabBarController.h"
#import "EditFuelViewController.h"
#import "EditGasStationViewController.h"

@interface UIFirstTabBarController ()

@end

@implementation UIFirstTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddItem:(id)sender {
    
    if ([self.tabBar.selectedItem.title isEqualToString:@"Fuel"]) {
        @try {
            [self performSegueWithIdentifier:@"goToNewFuel" sender:self];
        }
        @catch (NSException *exception) {
            NSLog(@"%@  no segue with identifier 'Replace_Connected' : %@", [self description], exception);
        }
        @finally {}
    }else{
        @try {
            [self performSegueWithIdentifier:@"goToNewGasStation" sender:self];
        }
        @catch (NSException *exception) {
            NSLog(@"%@  no segue with identifier 'Replace_Connected' : %@", [self description], exception);
        }
        @finally {}

    }
}
@end
