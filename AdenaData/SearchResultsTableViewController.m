//
//  SearchResultsTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/26/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "SearchResultsTableViewController.h"

@interface SearchResultsTableViewController ()

@property (nonatomic, strong) NSArray *searchResults;


@end

@implementation SearchResultsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self queryForJobListings];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    JobsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    
    PFObject *object = [self.searchResults objectAtIndex:indexPath.row];
    cell.jobTitleLabel.text = [object objectForKey:@"jobTitle"];
    NSString *company = [object objectForKey:@"jobEmployer"];
    NSString *location = [object objectForKey:@"jobLocation"];
    cell.companyNameLocation.text = [NSString stringWithFormat:@"%@ - %@", company, location];
    
    NSDate *date = object.createdAt;
    NSString *ago = [date timeAgoSinceNow];
    cell.jobDateLabel.text = ago;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 82;
    
}


-(void)queryForJobListings {
    
    [ProgressHUD show:nil];
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    [query orderByAscending:@"createdAt"];
    
    if (self.jobTitle != nil) {
        
        [query whereKey:@"jobTitle" matchesRegex:self.jobTitle modifiers:@"i"];
    }
    
    if (self.jobTitle != nil) {
        
        [query whereKey:@"jobLocation" matchesRegex:self.jobLocation modifiers:@"i"];
    }
    
    [query orderByAscending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            [ProgressHUD showError:@"Network Error"];
            
        }
        else {
            [ProgressHUD dismiss];
            self.searchResults = objects;
            [self.tableView reloadData];
        }
    }];
}

@end
