//
//  EventsTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "EventsTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIScrollView+EmptyDataSet.h"


@interface EventsTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

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
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
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
//    PFFile *thumbnail = [object objectForKey:@"eventImage"];
//    PFImageView *thumbnailImageView = (PFImageView*)cell.image;
//    thumbnailImageView.image = [UIImage imageNamed:@"adThumbnail"];
//    thumbnailImageView.file = thumbnail;
//    [thumbnailImageView loadInBackground];
    cell.eventImage.layer.cornerRadius = 4;
    cell.eventImage.clipsToBounds = YES;
    NSString *urlString = [object objectForKey:@"eventImageUrl"];
    [cell.eventImage sd_setImageWithURL:[NSURL URLWithString:urlString]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
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

//// Empty Table View Properties

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"No current events,\ncheck back soon!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:18],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:0.8 green:0.796 blue:0.796 alpha:1]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    
    if (self.events.count == 0) {
        return YES;
    }
    return NO;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointZero;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showEventDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; EventDetailTableViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.events objectAtIndex:indexPath.row];
        Event *event = [[Event alloc] init];
        event.title = [object objectForKey:@"eventName"];
        event.url = [object objectForKey:@"eventUrl"];
        //event.thumbnail = [object objectForKey:@"eventImage"];
        event.imageUrl = [object objectForKey:@"eventImageUrl"];
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
