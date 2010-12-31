//
//  ServerConfigViewController.h
//  SimpleGuiRemote
//
//  Created by jason van cleave on 12/26/10.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ServerConfigViewController : UIViewController {

	 UITextField *nameField;
    UITextField *addressField;
    
    UITextField *portField;
	UIButton *saveButton;
	NSDictionary *data;

}
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *portField;
@property (nonatomic, retain) IBOutlet UITextField *addressField;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) NSDictionary *data;
-(void) connect:(id) sender;
- (IBAction)onSaveButtonPress:(id)sender;
- (IBAction)onDeleteButtonPress:(id)sender;
- (IBAction)onPortEntry:(id)sender;
- (IBAction)onAddressEntry:(id)sender;
- (IBAction)onNameEntry:(id)sender;

@end
