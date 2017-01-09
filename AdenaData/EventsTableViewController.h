//
//  EventsTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
//#import <ParseUI/ParseUI.h>
#import "Event.h"
#import "EventsTableCell.h"
#import "ProgressHUD.h"
#import "DateTools.h"
#import "EventDetailTableViewController.h"

@interface EventsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end
