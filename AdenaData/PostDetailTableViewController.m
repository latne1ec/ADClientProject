//
//  PostDetailTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 7/16/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "PostDetailTableViewController.h"

@interface PostDetailTableViewController ()

@end

@implementation PostDetailTableViewController

@synthesize post, thePost;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = post.title;
    self.timeAgoLabel.text = _timeAgo;
    
    NSLog(@"Post: %@", post.title);
    self.postLocationLabel.text = post.location;
    self.postTextview.text = post.thePost;
    self.postImage.file = post.image;
    [self.postImage loadInBackground];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.flagButton setTitle:@"Flag Post" forState:UIControlStateNormal];
    
    [self.flagButton.titleLabel setTintColor:[UIColor colorWithRed:0.98 green:0.443 blue:0.259 alpha:1]];
    
    [self checkIfFlagged];

}


-(void)viewWillAppear:(BOOL)animated {
    [self setNavTextColor];

}

-(void)setNavTextColor {
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, .0);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:0.247 green:0.231 blue:0.227 alpha:1], NSForegroundColorAttributeName,
                                                                     shadow, NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"AvenirNext-Medium" size:18.5], NSFontAttributeName, nil]];
}

   
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) return _firstCell;
    if (indexPath.row == 1) return _secondCell;
    
    if (indexPath.row == 2) {
        _thirdCell.separatorInset = UIEdgeInsetsMake(0.f, 10000.0f, 0.f, 0.0f);
    }
    
    if (indexPath.row == 2) return _thirdCell;
    
    return nil;
}

-(void)checkIfFlagged {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Posts"];
    [query whereKey:@"postTitle" equalTo:post.title];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        if (error) {
           
        }
        else {
            
            if ([[[PFUser currentUser] objectForKey:@"flaggedPosts"] containsObject:object.objectId]) {
                [self.flagButton setTitle:@"Flagged" forState:UIControlStateNormal];
            }
            else {
                
            }
            
        }
    }];

}


- (IBAction)flagButtonTapped:(id)sender {
    
    if ([self.flagButton.titleLabel.text isEqualToString:@"Flagged"]) {
        
    }
    else {
    [ProgressHUD show:nil];
    PFQuery *query = [PFQuery queryWithClassName:@"Posts"];
    [query whereKey:@"postTitle" equalTo:post.title];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
       
        if (error) {
            [ProgressHUD dismiss];
            [ProgressHUD showError:@"Network Error"];
        }
        else {
            
        if ([[[PFUser currentUser] objectForKey:@"flaggedPosts"] containsObject:self.thePost.objectId]) {
            [ProgressHUD showError:@"Already Flagged"];
            [self.flagButton setTitle:@"Flagged" forState:UIControlStateNormal];
        }
        else {
            
        [ProgressHUD dismiss];
            [self.flagButton setTitle:@"Flagged" forState:UIControlStateNormal];
        self.thePost = object;
        [self.thePost incrementKey:@"flagCount" byAmount:[NSNumber numberWithInt:1]];
        [self.thePost saveInBackground];
            
        [[PFUser currentUser] addUniqueObject:self.thePost.objectId forKey:@"flaggedPosts"];
        [[PFUser currentUser] saveInBackground];
        }
            
        }
    }];
    
    NSNumber *flags = [self.thePost objectForKey:@"flagCount"];
    if ([flags isEqualToNumber:[NSNumber numberWithInt:5]]) {
        [thePost deleteInBackground];
        }
    }
}

- (IBAction)shareButtonTapped:(id)sender {
    
    NSString *finalString = [NSString stringWithFormat:@"%@ at %@", post.title, post.date];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[finalString]
                                      applicationActivities:nil];
    
    [self.navigationController presentViewController:activityViewController
                                            animated:YES
                                          completion:^{
                                              
                                          }];
}



@end
