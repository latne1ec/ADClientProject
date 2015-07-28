//
//  JobDetailTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/27/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "JobDetailTableViewController.h"

@interface JobDetailTableViewController ()

@end

@implementation JobDetailTableViewController

@synthesize cellOne, cellTwo, cellThree;
@synthesize job;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.jobLink.text = job.jobLink;
    self.companyNameLabel.text = job.jobEmployer;
    self.jobLocationLabel.text = job.jobLocation;
    self.jobPositionDetails.text = job.positionDetails;
    self.jobRequirements.text = job.requirements;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) return cellOne;
    if (indexPath.row == 1) return cellTwo;
    if (indexPath.row == 2) {
        cellThree.separatorInset = UIEdgeInsetsMake(0.f, 10000.0f, 0.f, 0.0f);
    }
    if (indexPath.row == 2) return cellThree;
    
    return nil;
}

- (IBAction)shareButtonTapped:(id)sender {
    
    NSString *finalString = [NSString stringWithFormat:@"%@ position at %@", self.job.jobTitle, self.job.jobEmployer];
    NSURL *URL = [NSURL URLWithString:self.job.jobLink];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[finalString, URL]
                                      applicationActivities:nil];
    
    [self.navigationController presentViewController:activityViewController
                                       animated:YES
                                     completion:^{
                                         
                                     }];
}
@end
