//
//  JobPostingsTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/27/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JobsTableCell.h"
#import "ProgressHUD.h"
#import "DateTools.h"
#import "SearchResultsTableViewController.h"
#import "FiltersTableViewController.h"
#import "Job.h"

@interface JobPostingsTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UIButton *moreFiltersButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITextField *jobTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobLocationTextView;


- (IBAction)moreFiltersTapped:(id)sender;
- (IBAction)searchButtonTapped:(id)sender;

@end
