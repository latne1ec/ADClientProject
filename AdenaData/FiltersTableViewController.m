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

@synthesize firstCell, secondCell, thirdCell, fourthCell;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Job Filters";
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:(UIImage *) [[UIImage imageNamed:@"cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(dismissViewControllerAnimated:completion:)];

}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)buttonTapped:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 200);
    _PickerView.transform = transfrom;
    _PickerView.alpha = _PickerView.alpha * (-1) + 1;
    [UIView commitAnimations];    
    
}



-(IBAction)button:(id)sender
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 200);
    _PickerView.transform = transfrom;
    _PickerView.alpha = _PickerView.alpha * (-1) + 1;
    [UIView commitAnimations];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) return firstCell;
    if (indexPath.row == 1) return secondCell;
    if (indexPath.row == 2) return thirdCell;
    if (indexPath.row == 3) return fourthCell;
    
    return nil;
}

@end
