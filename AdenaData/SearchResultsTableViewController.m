//
//  SearchResultsTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/26/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "UIScrollView+EmptyDataSet.h"


@interface SearchResultsTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSArray *searchResults;


@end

@implementation SearchResultsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
   
    if (self.filterQuery == nil) {
        [self queryForJobListings];
    }
    else {
        
        if ([self.positionType isEqualToString:@"All"]) {
            NSLog(@"All");
            [self queryForAllWithFilters];
        }
        
        else{
        
        [self queryWithFilters];
            
        }
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
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
    
    if (self.jobTitle != nil) {
        [query whereKey:@"jobTitle" matchesRegex:self.jobTitle modifiers:@"i"];
    }
    if (self.jobLocation != nil) {
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
            NSLog(@"Objects: %lu", (unsigned long)objects.count);
            [self.tableView reloadData];
        }
    }];
}

-(void)queryWithFilters {
    
    [ProgressHUD show:nil];
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    
    if (self.jobTitle != nil) {
        [query whereKey:@"jobTitle" matchesRegex:self.jobTitle modifiers:@"i"];
    }
    if (self.jobLocation != nil) {
        [query whereKey:@"jobLocation" matchesRegex:self.jobLocation modifiers:@"i"];
    }
    if (self.positionType != nil) {
        [query whereKey:@"positionType" matchesRegex:self.positionType modifiers:@"i"];
    }
    if (self.employmentType != nil) {
        [query whereKey:@"employmentType" matchesRegex:self.employmentType modifiers:@"i"];
    }
    if (self.educationRequirements != nil) {
        [query whereKey:@"educationRequirement" matchesRegex:self.educationRequirements modifiers:@"i"];
    }
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            [ProgressHUD showError:@"Network Error"];
            
        }
        else {
            [ProgressHUD dismiss];
            self.searchResults = objects;
            NSLog(@"Objects: %lu", (unsigned long)objects.count);
            [self.tableView reloadData];
        }
    }];
}

-(void)queryForAllWithFilters {
    
    [ProgressHUD show:nil];
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    
    if (self.jobTitle != nil) {
        [query whereKey:@"jobTitle" matchesRegex:self.jobTitle modifiers:@"i"];
    }
    if (self.jobLocation != nil) {
        [query whereKey:@"jobLocation" matchesRegex:self.jobLocation modifiers:@"i"];
    }
    if (self.employmentType != nil) {
        [query whereKey:@"employmentType" matchesRegex:self.employmentType modifiers:@"i"];
    }
    if (self.educationRequirements != nil) {
        [query whereKey:@"educationRequirement" matchesRegex:self.educationRequirements modifiers:@"i"];
    }
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            [ProgressHUD showError:@"Network Error"];
            
        }
        else {
            [ProgressHUD dismiss];
            self.searchResults = objects;
            NSLog(@"Objects: %lu", (unsigned long)objects.count);
            [self.tableView reloadData];
        }
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showJobDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; JobDetailTableViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.searchResults objectAtIndex:indexPath.row];
        Job *job = [[Job alloc] init];
        job.jobTitle = [object objectForKey:@"jobTitle"];
        job.jobLocation = [object objectForKey:@"jobLocation"];
        job.jobEmployer = [object objectForKey:@"jobEmployer"];
        job.jobDate = object.createdAt;
        job.jobLink = [object objectForKey:@"jobLink"];
        job.positionDetails = [object objectForKey:@"positionDetails"];
        job.requirements = [object objectForKey:@"jobRequirements"];
        destViewController.job = job;
        
        [segue.destinationViewController setTitle:job.jobTitle];
        destViewController.hidesBottomBarWhenPushed = YES;
        
    }
}

//// Empty Table View Properties

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"No results found";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:18],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:0.8 green:0.796 blue:0.796 alpha:1]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    
    if (self.searchResults.count == 0) {
        return YES;
    }
    return NO;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointZero;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}


@end
