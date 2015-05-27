//
//  FiltersTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/26/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltersTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *thirdCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *fourthCell;



- (IBAction)buttonTapped:(id)sender;

@end
