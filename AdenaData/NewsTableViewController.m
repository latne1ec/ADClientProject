//
//  NewsTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "NewsTableViewController.h"
#import "PostDetailTableViewController.h"
#import "WelcomeViewController.h"
#import "UIScrollView+EmptyDataSet.h"


@interface NewsTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AD Now";
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    
    if (![PFUser currentUser]) {
        
        WelcomeViewController *wvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Welcome"];
        [self.navigationController presentViewController:wvc animated:YES completion:^{
           
        }];
    }
    
    [self queryForNewsArticles];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(queryForNewsArticles)
                  forControlEvents:UIControlEventValueChanged];
    self.tableView.tableFooterView = [UIView new];
    
    //Nav Bar Image
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adenaDataSmall"]]];
    self.navigationItem.leftBarButtonItem = item;
    


}


-(void)viewWillDisappear:(BOOL)animated {
    
    [self.timer invalidate];
    
    [self performSelector:@selector(changeTextAttributes) withObject:nil afterDelay:0.5];

}

-(void)changeTextAttributes {
 
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, .0);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:0.247 green:0.231 blue:0.227 alpha:1], NSForegroundColorAttributeName,
                                                                     shadow, NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"AvenirNext-Medium" size:18.5], NSFontAttributeName, nil]];
}
     

-(void) updateCountdown {
    
    
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"US/Eastern"];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:timezone];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [df setDateFormat:@"hh:mm:ss"];
    //[df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    
    NSInteger hoursFromGMT = [[NSTimeZone localTimeZone] secondsFromGMT] / 3600;
    //NSLog(@"HOURS: %ld", (long)hoursFromGMT);
    

    NSString *f = [df stringFromDate:now];
    //NSLog(@"NY: %@", f);

    NSDate *date = [df dateFromString:f];

    
    
    [df setTimeZone:timezone];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [df setDateFormat:@"hh:mm:ss"];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    date = [df dateFromString:f];
    
    //NSLog(@"Date: %@", date);
    
    NSDateComponents *componentsHours = [calendar components:NSHourCalendarUnit fromDate:[df dateFromString:f]];
    NSDateComponents *componentMint = [calendar components:NSMinuteCalendarUnit fromDate:[df dateFromString:f]];
    NSDateComponents *componentSec = [calendar components:NSSecondCalendarUnit fromDate:[df dateFromString:f]];

    NSString *countdownText = [NSString stringWithFormat:@"%02d:%02d:%02d", 23+(hoursFromGMT+4)-componentsHours.hour, 60-componentMint.minute, 60-componentSec.second];
    
    self.navigationItem.title = countdownText;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, .0);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:0.937 green:0.416 blue:0.231 alpha:1], NSForegroundColorAttributeName,
                                                          shadow, NSShadowAttributeName,
                                                          [UIFont fontWithName:@"AvenirNext-DemiBold" size:21.0], NSFontAttributeName, nil]];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationItem.title = @"";
    self.title = @"AD Now";
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, .0);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:0.937 green:0.416 blue:0.231 alpha:1], NSForegroundColorAttributeName,
                                                                     shadow, NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"AvenirNext-DemiBold" size:21.0], NSFontAttributeName, nil]];
    
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.newsArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NewsCell";
    NewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *object = [self.newsArticles objectAtIndex:indexPath.row];
    PFFile *thumbnail = [object objectForKey:@"postImageThumbnail"];
    PFImageView *thumbnailImageView = (PFImageView*)cell.image;
    thumbnailImageView.image = [UIImage imageNamed:@"adThumbnail.jpeg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    cell.image.layer.cornerRadius = 2;
    cell.image.clipsToBounds = YES;
    
    cell.imageBkg.layer.cornerRadius = 4;
    cell.imageBkg.clipsToBounds = YES;
    
    cell.title.text = [object objectForKey:@"postTitle"];
    //NSDate *date = object.createdAt;
    //NSString *ago = [date timeAgoSinceNow];
    cell.articleDate.tag = indexPath.row;
    NSString *postLocation = [object objectForKey:@"postLocation"];
    cell.articleDate.text = [NSString stringWithFormat:@"%@",postLocation];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 88;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showPostDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; PostDetailTableViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.newsArticles objectAtIndex:indexPath.row];
        NewsArticle *article = [[NewsArticle alloc] init];
        article.title = [object objectForKey:@"postTitle"];
        article.location = [object objectForKey:@"postLocation"];
        article.image = [object objectForKey:@"postImage"];
        article.thePost = [object objectForKey:@"postText"];
        NSString *objectId = object.objectId;
        
        destViewController.title = article.title;
        destViewController.postLocationLabel.text = article.location;
        destViewController.postImage.file = article.image;
        destViewController.post = article;
        destViewController.postTextview.text = article.thePost;
        destViewController.objectId = objectId;
        
        NSDate *date = object.createdAt;
        NSString *ago = [date timeAgoSinceNow];
        
        destViewController.timeAgo = ago;
        
        [segue.destinationViewController setTitle:article.title];
        
        destViewController.hidesBottomBarWhenPushed = YES;
     
    }
}

-(void)queryForNewsArticles {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *dc = [cal components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];
    
    NSInteger hoursFromGMT = [[NSTimeZone localTimeZone] secondsFromGMT] / 3600;
    
    //NSLog(@"YO: %d", hoursFromGMT);
    
    [dc setHour:-24+(hoursFromGMT)];
    [dc setMinute:-[dc minute]];
    [dc setSecond:-[dc second]];
    
    NSDate *yesterday = [cal dateByAddingComponents:dc toDate:[[NSDate alloc] init] options:0];

    [ProgressHUD show:nil];
    PFQuery *query = [PFQuery queryWithClassName:@"Posts"];
    [query whereKey:@"createdAt" greaterThan:yesterday];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        if (error) {
            [ProgressHUD showError:@"Network Error"];
        }
        else {
            
            self.newsArticles = objects;
            [self.tableView reloadData];
            [ProgressHUD dismiss];
        }
        
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
    }];
}

- (IBAction)addPostTapped:(id)sender {
    
    AddPostTableViewController *destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPost"];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:destViewController];
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[navigationController navigationItem] setBackBarButtonItem:newBackButton];
    [self.navigationController presentViewController:navigationController animated:YES completion:^{
    }];
}


//// Empty Table View Properties

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"No events now,\ncheck back soon!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:18],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:0.8 green:0.796 blue:0.796 alpha:1]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    
    if (self.newsArticles.count == 0) {
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



@end
