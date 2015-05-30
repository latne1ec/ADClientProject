//
//  JobDetailTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/27/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Job.h"

@interface JobDetailTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *cellOne;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellTwo;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellThree;

@property (nonatomic, strong) Job *job;

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *jobLocationLabel;
@property (weak, nonatomic) IBOutlet UITextView *jobLink;

@property (weak, nonatomic) IBOutlet UITextView *jobPositionDetails;

@property (weak, nonatomic) IBOutlet UITextView *jobRequirements;


- (IBAction)shareButtonTapped:(id)sender;



@end
