//
//  PostDetailTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 7/16/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "NewsArticle.h"
#import "ProgressHUD.h"

@interface PostDetailTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *thirdCell;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;

@property (weak, nonatomic) IBOutlet UILabel *postTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *postLocationLabel;

@property (weak, nonatomic) IBOutlet UITextView *postTextview;

@property (nonatomic, strong) NSString *objectId;



@property (nonatomic, strong) PFObject *thePost;


@property (nonatomic, strong) NewsArticle *post;

@property (nonatomic, strong) NSString *timeAgo;
@property (weak, nonatomic) IBOutlet UIButton *flagButton;
- (IBAction)shareButtonTapped:(id)sender;

- (IBAction)flagButtonTapped:(id)sender;

@end
