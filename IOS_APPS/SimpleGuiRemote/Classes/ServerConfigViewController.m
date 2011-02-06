//
//  ServerConfigViewController.m
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/26/10.
//  Copyright 2010 . All rights reserved.
//

#import "ServerConfigViewController.h"
#import "ServerConfigValueObject.h"
#import "OFAppViewController.h"

@implementation ServerConfigViewController
@synthesize nameField, portField, addressField, saveButton, data;


- (IBAction)onNameEntry:(id)sender 
{
	
}
- (IBAction)onAddressEntry:(id)sender 
{
	
}
- (IBAction)onPortEntry:(id)sender {
}
- (IBAction)onSaveButtonPress:(id)sender
{
	
	
	BOOL needsIndex = ((int)[data objectForKey:[ServerConfigValueObject INDEX_KEY]] == 0);
	NSDictionary *dictToSend;
	if (needsIndex) {
		dictToSend = [[NSDictionary alloc] initWithObjectsAndKeys:
										@"666",
										[ServerConfigValueObject INDEX_KEY],
										nameField.text,
										[ServerConfigValueObject NAME_KEY],
										addressField.text, 
										[ServerConfigValueObject SERVER_KEY], 
										portField.text, 
										[ServerConfigValueObject PORT_KEY], 
										nil];
		
		
	}else {
		dictToSend = [[NSDictionary alloc] initWithObjectsAndKeys:
					[data objectForKey:[ServerConfigValueObject INDEX_KEY]],
					[ServerConfigValueObject INDEX_KEY],
					nameField.text,
					[ServerConfigValueObject NAME_KEY],
					addressField.text, 
					[ServerConfigValueObject SERVER_KEY], 
					portField.text, 
					[ServerConfigValueObject PORT_KEY], 
					nil];
	}

	
	if (![nameField.text isEqual:@""] && ![addressField.text isEqual:@""] && ![portField.text isEqual:@""]) {
		NSLog(@"onSaveButtonPress validates %@ %@", addressField.text, portField.text);

		[[NSNotificationCenter defaultCenter] 
		 postNotificationName:onServerAdd 
		 object:self
		 userInfo: dictToSend];
		[self.navigationController popViewControllerAnimated:YES];
	}
}
- (IBAction)onDeleteButtonPress:(id)sender
{
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName:onServerDelete 
	 object:self
	 userInfo: [NSDictionary dictionaryWithObjectsAndKeys:
				[data objectForKey:[ServerConfigValueObject INDEX_KEY]],
				[ServerConfigValueObject INDEX_KEY],
				nameField.text,
				[ServerConfigValueObject NAME_KEY],
				addressField.text, 
				[ServerConfigValueObject SERVER_KEY], 
				portField.text, 
				[ServerConfigValueObject PORT_KEY], 
				nil]
	 ];
	[self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[nameField release];
	[addressField release];
    [portField release];
    [saveButton release];
    [super viewDidUnload];
}


- (void)dealloc {

	//[data release];
  
    [super dealloc];
}

-(void) viewWillAppear:(BOOL)animated
{
	if (data) {
		nameField.text = [data objectForKey:[ServerConfigValueObject NAME_KEY]];
		addressField.text = [data objectForKey:[ServerConfigValueObject SERVER_KEY]];
		portField.text = [data objectForKey:[ServerConfigValueObject PORT_KEY]];
		UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Connect" style:UIBarButtonItemStyleBordered target:self action:@selector(connect:)];
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		self.navigationItem.rightBarButtonItem = addButton;
		[addButton release];
	}
}
-(void) connect:(id) sender
{
	NSLog(@"connecting");
	
	
	self.navigationItem.rightBarButtonItem = nil;
	OFAppViewController * appViewController  = [[OFAppViewController alloc] initWithStyle:UITableViewStylePlain];
	appViewController.data = self.data;
	[self.navigationController pushViewController:appViewController animated:YES];
	[appViewController release];
}
@end
