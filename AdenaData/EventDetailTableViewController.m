//
//  EventDetailTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "EventDetailTableViewController.h"

@interface EventDetailTableViewController ()

@end

@implementation EventDetailTableViewController

@synthesize imageCell, eventDateCell, eventDescriptionCell;
@synthesize event;
@synthesize eventImage;
@synthesize eventDate;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = event.title;
    self.eventDate.text = event.date;
    self.eventDescription.text = event.eventDescription;
    [self.eventDescription sizeToFit];
    [self.eventLink setTextColor:[UIColor colorWithRed:0.918 green:0.4 blue:0.22 alpha:1]];
    self.eventLink.text = event.url;
    self.eventImage.file = event.thumbnail;
    [eventImage loadInBackground];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.957 green:0.957 blue:0.957 alpha:1];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) return imageCell;
    if (indexPath.row == 1) return eventDateCell;
    if (indexPath.row == 2) return eventDescriptionCell;
    
    return nil;
}

@end