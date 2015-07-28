//
//  EventsTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "EventsTableViewController.h"

@interface EventsTableViewController ()

@end

@implementation EventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self queryForEvents];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(queryForEvents)
                  forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableFooterView = [UIView new];

    //Nav Bar Image
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adenaDataSmall"]]];
    self.navigationItem.leftBarButtonItem = item;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    EventsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *object = [self.events objectAtIndex:indexPath.row];
    PFFile *thumbnail = [object objectForKey:@"eventImage"];
    PFImageView *thumbnailImageView = (PFImageView*)cell.image;
    thumbnailImageView.image = [UIImage imageNamed:@"adThumbnail"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    cell.image.layer.cornerRadius = 4;
    cell.image.clipsToBounds = YES;
    cell.imageBkg.layer.cornerRadius = 8;
    cell.imageBkg.clipsToBounds = YES;
    cell.tableCellFade.layer.cornerRadius = 3;
    cell.tableCellFade.clipsToBounds = YES;

    cell.title.text = [object objectForKey:@"eventName"];
    cell.eventDate.text = [object objectForKey:@"eventDate"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 220;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showEventDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; EventDetailTableViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.events objectAtIndex:indexPath.row];
        Event *event = [[Event alloc] init];
        event.title = [object objectForKey:@"eventName"];
        event.url = [object objectForKey:@"eventUrl"];
        event.thumbnail = [object objectForKey:@"eventImage"];
        event.date = [object objectForKey:@"eventDate"];
        event.eventDescription = [object objectForKey:@"eventDescription"];
        event.url = [object objectForKey:@"eventUrl"];
        destViewController.event = event;
        
        [segue.destinationViewController setTitle:event.title];
        destViewController.hidesBottomBarWhenPushed = YES;
        
    }
}

-(void)queryForEvents {
    
    [ProgressHUD show:nil];
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            [ProgressHUD showError:@"Network Error"];
        }
        else {
            [ProgressHUD dismiss];
            self.events = objects;
            [self.tableView reloadData];
        }
        
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
        
    }];
}

@end
