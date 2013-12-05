//
//  ADSAuthorEditViewController.m
//  BooksMobile
//
//  Created by Glauco Aquino on 30/11/13.
//  Copyright (c) 2013 UNIFOR. All rights reserved.
//

#import "ADSAuthorEditViewController.h"
#import "ADSAuthor.h"
#import "ADSAppDelegate.h"

@interface ADSAuthorEditViewController ()

@end

@implementation ADSAuthorEditViewController

-(void)viewWillAppear:(BOOL)animated {
	if (_author != nil) {
		_authorIdTextField.text = [NSString stringWithFormat:@"%@", _author.authorId];
		_nameTextField.text = _author.name;
	}
}

- (IBAction)saveButtonDidTap:(id)sender {
	NSManagedObjectContext *context = [ADSAppDelegate sharedAppDelegate].managedObjectContext;
	
	if (_author == nil)
		_author = [NSEntityDescription insertNewObjectForEntityForName:@"Authors" inManagedObjectContext:context];
	
	_author.authorId = [NSNumber numberWithInt:[_authorIdTextField.text integerValue]];
	
	_author.name = _nameTextField.text;

	[context save:NULL];
	
	[self.navigationController popViewControllerAnimated:YES];
}


@end
