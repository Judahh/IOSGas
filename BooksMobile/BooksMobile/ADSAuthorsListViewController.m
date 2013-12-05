//
//  ADSAuthorsListViewController.m
//  BooksMobile
//
//  Created by Glauco Aquino on 30/11/13.
//  Copyright (c) 2013 UNIFOR. All rights reserved.
//

#import "ADSAuthorsListViewController.h"

#import "ADSAuthor.h"
#import "ADSAppDelegate.h"

#import "ADSAuthorViewController.h"

@interface ADSAuthorsListViewController ()

@end

@implementation ADSAuthorsListViewController {
	NSArray *_authors;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
    NSFetchRequest *request = [[ADSAppDelegate sharedAppDelegate].managedObjectModel fetchRequestTemplateForName:@"FetchRequestForAllAuthors"];
	
	NSError *error = nil;
	_authors = [[ADSAppDelegate sharedAppDelegate].managedObjectContext executeFetchRequest:request error:&error];
	
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _authors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ADSAuthor *author = [_authors objectAtIndex:indexPath.row];
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DEFAULT" forIndexPath:indexPath];
	
	cell.textLabel.text = author.name;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"DETAIL"]) {
		UITableViewCell *cell = sender;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
		
		ADSAuthor *author = [_authors objectAtIndex:indexPath.row];
		
		ADSAuthorViewController *ctrl = segue.destinationViewController;
		ctrl.author = author;
	}
}

@end
