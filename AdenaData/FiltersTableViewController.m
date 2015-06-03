//
//  FiltersTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/26/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "FiltersTableViewController.h"

@interface FiltersTableViewController ()

@property (nonatomic, strong) UIPickerView *PickerView;


@end

@implementation FiltersTableViewController

@synthesize firstCell, secondCell;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Search Jobs";
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:(UIImage *) [[UIImage imageNamed:@"cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(dismissViewControllerAnimated:completion:)];
    
    CALayer *btn1 = [self.searchButton layer];
    [btn1 setMasksToBounds:YES];
    [btn1 setCornerRadius:3.0f];
    
    CALayer *btn2 = [self.positionTypeButton layer];
    [btn2 setMasksToBounds:YES];
    [btn2 setCornerRadius:3.0f];
    
    CALayer *btn3 = [self.employmentTypeButton layer];
    [btn3 setMasksToBounds:YES];
    [btn3 setCornerRadius:3.0f];
    
    CALayer *btn4 = [self.educationReqButton layer];
    [btn4 setMasksToBounds:YES];
    [btn4 setCornerRadius:3.0f];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.jobTitleTextfield.delegate = self;
    self.jobLocationTextField.delegate = self;

}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.backBarButtonItem.title = @" ";
    
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
}


-(void)dismissKeyboard {
    
    [self.jobTitleTextfield resignFirstResponder];
    [self.jobLocationTextField resignFirstResponder];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.jobTitleTextfield resignFirstResponder];
    [self.jobLocationTextField resignFirstResponder];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    
    [self dismissKeyboard];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)positionTypeTapped:(id)sender {
    
    [self dismissKeyboard];
    NSArray *positionTypes = [NSArray arrayWithObjects:@"All", @"Job",@"Internship", @"Volunteer", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Position Type"
                                            rows:positionTypes
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                                                                      
                                           [self.positionTypeButton setTitle:selectedValue forState:UIControlStateNormal];
                                           self.positionType = selectedValue;
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    
}

- (IBAction)employmentTypeTapped:(id)sender {
    
    [self dismissKeyboard];
    NSArray *employmentTypes = [NSArray arrayWithObjects:@"Temporary", @"Per-Diem", @"Part-Time", @"Full-Time", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Employment Type"
                                            rows:employmentTypes
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                           
                                           [self.employmentTypeButton setTitle:selectedValue forState:UIControlStateNormal];
                                           self.employmentType = selectedValue;
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    
}

- (IBAction)educationReqTapped:(id)sender {
    
    [self dismissKeyboard];
    NSArray *educationRequirements = [NSArray arrayWithObjects:@"No requirement", @"High School", @"2-Year Degree", @"4-Year Degree", @"Masters Degree", @"J.D.", @"M.D.", @"Doctorate", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Education"
                                            rows:educationRequirements
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                           
                                           [self.educationReqButton setTitle:selectedValue forState:UIControlStateNormal];
                                           self.educationRequirement = selectedValue;
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) return firstCell;
    if (indexPath.row == 1) return secondCell;
    
    return nil;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField; {
    
    if([self.jobTitleTextfield isFirstResponder]){
        [self.jobLocationTextField becomeFirstResponder];
    }
    else if ([self.jobLocationTextField isFirstResponder]){
        [self.jobLocationTextField resignFirstResponder];
    }
    return YES;
}



- (IBAction)searchButtonTapped:(id)sender {
    
    NSString *jobTitle = [self.jobTitleTextfield.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *jobLocation = [self.jobLocationTextField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    SearchResultsTableViewController *destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResults"];
    
    destViewController.jobTitle = jobTitle;
    destViewController.jobLocation = jobLocation;
    destViewController.positionType = self.positionType;
    destViewController.employmentType = self.employmentType;
    destViewController.educationRequirements = self.educationRequirement;
    destViewController.filterQuery = @"Yes";
    destViewController.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:destViewController animated:YES];
    
}
@end
