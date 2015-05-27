//
//  SearchResultsTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/26/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JobsTableCell.h"
#import "ProgressHUD.h"
#import "DateTools.h"
#import "Job.h"


@interface SearchResultsTableViewController : UITableViewController

@property (nonatomic, strong) Job *job;
@property (nonatomic, copy) NSString *jobTitle;
@property (nonatomic, copy) NSString *jobLocation;

@end
