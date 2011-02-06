//
//  ServersViewController.m
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/26/10.
//  Copyright 2010 . All rights reserved.
//

#import "ServersViewController.h"
#import "ServerConfigViewController.h"
#import "ServerConfigValueObject.h"
#import	"OFAppViewController.h"

@implementation ServersViewController

@synthesize serversArray;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


-(void) loadView
{
	[super loadView];
	self.title = @"Servers";

	NSLog(@"ServersViewController loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"ServersViewController loadView");
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
}
-(void) add:(id) sender
{
	ServerConfigViewController *serverConfigViewController = [[ServerConfigViewController alloc] initWithNibName:@"ServerConfigViewController" bundle:nil];
	[self.navigationController pushViewController:serverConfigViewController animated:YES];

	//[self pushViewController:serverConfigViewController];
}

- (void)viewWillAppear:(BOOL)animated {
	
	[[self tableView] reloadData];
	NSLog(@"ServersViewController viewWillAppear %@:serversArray", serversArray);
    [super viewWillAppear:animated];
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
    return [serversArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    //PageValueObject *pageData = (PageValueObject*)[pagesArray objectAtIndex:(NSUInteger)indexPath.row];
	NSDictionary *rowData = [serversArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [rowData objectForKey:[ServerConfigValueObject NAME_KEY]];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"accessoryButtonTappedForRowWithIndexPath");
	OFAppViewController * appViewController  = [[OFAppViewController alloc] initWithStyle:UITableViewStylePlain];
	appViewController.data = [serversArray objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:appViewController animated:YES];
	[appViewController release];
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
    ServerConfigViewController *serverConfigViewController = [[ServerConfigViewController alloc] initWithNibName:@"ServerConfigViewController" bundle:nil];
    NSDictionary *rowData = [serversArray objectAtIndex:indexPath.row]; 
	serverConfigViewController.data = rowData;
	// ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:serverConfigViewController animated:YES];
    [serverConfigViewController release];
	[rowData release];
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
	//[serversArray release];
    [super dealloc];
}


@end

