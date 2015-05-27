//
//  EventDetailTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Event.h"

@interface EventDetailTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *imageCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *eventDateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *eventDescriptionCell;

@property (nonatomic, strong) Event *event;
@property (weak, nonatomic) IBOutlet PFImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;


@property (weak, nonatomic) IBOutlet UITextView *eventLink;

@end
