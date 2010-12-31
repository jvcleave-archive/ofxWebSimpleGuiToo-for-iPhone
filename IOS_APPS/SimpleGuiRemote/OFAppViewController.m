//
//  RootViewController.m
//  NativeAppNavBased
//
//  Created by jason van cleave on 12/21/10.
//  Copyright 2010 . All rights reserved.
//

#import "OFAppViewController.h"
#import "PageDetailViewController.h"
#import "PageValueObject.h"
#import "DataModel.h"
#import "ServerConfigValueObject.h"

@implementation OFAppViewController

@synthesize pagesArray, data, model;


#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
	NSLog(@"OFAppViewController initWithStyle");
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Pages";
	model = [[OFAppDataModel alloc] init];
	self.pagesArray = model.pagesArray;
	[model connectToServer:[data objectForKey:[ServerConfigValueObject SERVER_KEY]] port:[data objectForKey:[ServerConfigValueObject PORT_KEY]]];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	if (model.connectionError) 
    {
        
        NSLog(@"model error %@", model.connectionError);
        UIAlertView *alert = [[[UIAlertView alloc] 
                               initWithTitle:@"No connection" 
                               message:model.connectionURL 
                               delegate:self 
                               cancelButtonTitle:@"Cancel" 
                               otherButtonTitles:nil] autorelease];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
    }
}
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [pagesArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	PageValueObject *pageData = (PageValueObject*)[pagesArray objectAtIndex:(NSUInteger)indexPath.row];
    cell.textLabel.text = pageData.name;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//NSString *so = [NSString alloc]
	
	
	//NSLog(@" RootViewController  didSelectRowAtIndexPath %@", [pagesArray objectAtIndex:(NSUInteger)indexPath.row]);
	
	PageValueObject *pageData = (PageValueObject*)[pagesArray objectAtIndex:(NSUInteger)indexPath.row];
	PageDetailViewController *pageDetailViewController = [[PageDetailViewController alloc] init];
	pageDetailViewController.title = pageData.name;
	pageDetailViewController.pageData = pageData;
	
	[self.navigationController pushViewController:pageDetailViewController animated:TRUE];
	[pageDetailViewController release];
	[pageData release];

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	
	NSLog(@"OFAppViewController dealloc - may crash here if removing pagesArray");
	//[pagesArray release];
	//[data release];
	NSLog(@"OFAppViewController dealloc");
	//[model release];
	
	
    [super dealloc];
}


@end

