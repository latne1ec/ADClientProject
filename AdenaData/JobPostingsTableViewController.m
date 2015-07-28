//
//  JobPostingsTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/27/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "JobPostingsTableViewController.h"

@interface JobPostingsTableViewController ()

@property (nonatomic, strong) NSArray *jobs;


@end

@implementation JobPostingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, 320, 64)];
    
    [self queryForJobs];
    self.tableView.tableFooterView = [UIView new];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(queryForJobs)
                  forControlEvents:UIControlEventValueChanged];
    
    //Nav Bar Image
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adLogo2"]]];
    self.navigationItem.leftBarButtonItem = item;
    
    CALayer *btn1 = [self.searchButton layer];
    [btn1 setMasksToBounds:YES];
    [btn1 setCornerRadius:3.0f];
    
    CALayer *btn2 = [self.moreFiltersButton layer];
    [btn2 setMasksToBounds:YES];
    [btn2 setCornerRadius:3.0f];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    
    self.jobTitleTextField.delegate = self;
    self.jobLocationTextView.delegate = self;
    
}

- (void) dismissKeyboard {
    // add self
    [self.jobTitleTextField resignFirstResponder];
    [self.jobLocationTextView resignFirstResponder];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.jobTitleTextField resignFirstResponder];
    [self.jobLocationTextView resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    [[UIView appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setBackgroundColor:[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1]];
    
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:12]];
    
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor colorWithRed:0.98 green:0.443 blue:0.259 alpha:1]];
    
    if (section == 0) {
        return nil;
    }
    if (section == 1) {
        
        return @"Most Recent";
    }
    
    return nil;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == 0) {
        
        return 0;
    }
    else {
        return self.jobs.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    JobsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    
    PFObject *object = [self.jobs objectAtIndex:indexPath.row];
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



-(void)queryForJobs {
    
    [ProgressHUD show:nil];
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            [ProgressHUD showError:@"Network Error"];
            
        }
        else {
            [ProgressHUD dismiss];
            self.jobs = objects;
            [self.tableView reloadData];
        }
        
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField; {
    
    if([self.jobTitleTextField isFirstResponder]){
        [self.jobLocationTextView becomeFirstResponder];
    }
    else if ([self.jobLocationTextView isFirstResponder]){
        [self.jobLocationTextView resignFirstResponder];
        [self searchButtonTapped:self];
    }
    return YES;
}



- (IBAction)moreFiltersTapped:(id)sender {
    
    FiltersTableViewController *destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Filters"];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:destViewController];
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[navigationController navigationItem] setBackBarButtonItem:newBackButton];
    [self.navigationController presentViewController:navigationController animated:YES completion:^{
    }];
    
}

- (IBAction)searchButtonTapped:(id)sender {
    
    NSString *jobTitle = [self.jobTitleTextField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *jobLocation = [self.jobLocationTextView.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];

    SearchResultsTableViewController *destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResults"];
    
    destViewController.jobTitle = jobTitle;
    destViewController.jobLocation = jobLocation;
    destViewController.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:destViewController animated:YES];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetailFromJobsTab"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; JobDetailTableViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.jobs objectAtIndex:indexPath.row];
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


@end
