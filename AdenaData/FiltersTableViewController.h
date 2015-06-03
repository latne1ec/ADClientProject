//
//  FiltersTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/26/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"
#import "SearchResultsTableViewController.h"
#import "UIActionSheet+Blocks.h"

@interface FiltersTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;
@property (weak, nonatomic) IBOutlet UITextField *jobTitleTextfield;
@property (weak, nonatomic) IBOutlet UITextField *jobLocationTextField;
@property (weak, nonatomic) IBOutlet UIButton *positionTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *employmentTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *educationReqButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;


@property (nonatomic, copy) NSString *positionType;
@property (nonatomic, copy) NSString *employmentType;
@property (nonatomic, copy) NSString *educationRequirement;
@property (nonatomic, copy) NSString *queryFilters;





- (IBAction)positionTypeTapped:(id)sender;
- (IBAction)employmentTypeTapped:(id)sender;
- (IBAction)educationReqTapped:(id)sender;
- (IBAction)searchButtonTapped:(id)sender;


@end
