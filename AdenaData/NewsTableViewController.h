//
//  NewsTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "NewsTableCell.h"
#import "ProgressHUD.h"
#import "NewsArticle.h"
#import "NewsDetailViewController.h"
#import <ParseUI/ParseUI.h>
#import "DateTools.h"

@interface NewsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *newsArticles;
@property (nonatomic, strong) NSString *article;
@property (nonatomic, strong) UIRefreshControl *refreshControl;




@end
