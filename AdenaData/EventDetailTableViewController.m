//
//  EventDetailTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "EventDetailTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface EventDetailTableViewController ()

@end

@implementation EventDetailTableViewController

@synthesize imageCell, eventDateCell, eventDescriptionCell;
@synthesize event;
//@synthesize eventImage;
@synthesize eventDate;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = event.title;
    self.eventDate.text = event.date;
    self.eventDescription.text = event.eventDescription;
    [self.eventDescription sizeToFit];
    [self.eventLink setTextColor:[UIColor colorWithRed:0.918 green:0.4 blue:0.22 alpha:1]];
    self.eventLink.text = event.url;
    NSString *urlString = event.imageUrl;
    [self.eventImage sd_setImageWithURL:[NSURL URLWithString:urlString]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//    self.eventImage.file = event.thumbnail;
//    [eventImage loadInBackground];
    
    self.tableView.tableFooterView = [UIView new];
    
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
    
    if (indexPath.row == 2) {
        eventDescriptionCell.separatorInset = UIEdgeInsetsMake(0.f, 10000.0f, 0.f, 0.0f);
    }
    
    
    if (indexPath.row == 2) return eventDescriptionCell;
    
    return nil;
}

- (IBAction)shareButtonTapped:(id)sender {
    
    NSString *finalString = [NSString stringWithFormat:@"%@ at %@", event.title, event.date];
    NSURL *URL = [NSURL URLWithString:self.eventLink.text];
        
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[finalString, URL]
                                      applicationActivities:nil];
    
    [self.navigationController presentViewController:activityViewController
                                            animated:YES
                                          completion:^{
                                              
                                          }];
    
    
}
@end
