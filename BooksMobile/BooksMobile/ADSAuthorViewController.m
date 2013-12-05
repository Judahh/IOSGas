//
//  ADSAuthorViewController.m
//  BooksMobile
//
//  Created by Glauco Aquino on 30/11/13.
//  Copyright (c) 2013 UNIFOR. All rights reserved.
//

#import "ADSAuthorViewController.h"

#import "ADSAppDelegate.h"

#import "ADSAuthorEditViewController.h"

@interface ADSAuthorViewController ()

@end

@implementation ADSAuthorViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	_authorIdLabel.text = [NSString stringWithFormat:@"%@", _author.authorId];
	_nameLabel.text = _author.name;
}

- (IBAction)deleteButtonDidTap:(id)sender {
	NSManagedObjectContext *context = [ADSAppDelegate sharedAppDelegate].managedObjectContext;
	
	[context deleteObject:_author];

	NSError *error = nil;
	[context save:&error];
	
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	ADSAuthorEditViewController *ctrl = segue.destinationViewController;
	ctrl.author = self.author;
}

@end
