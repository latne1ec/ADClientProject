//
//  NewsTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "NewsTableViewController.h"

@interface NewsTableViewController ()

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self queryForNewsArticles];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(queryForNewsArticles)
                  forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableFooterView = [UIView new];
    
    
    //Nav Bar Image
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adenaDataSmall"]]];
    self.navigationItem.leftBarButtonItem = item;

}

-(void)viewWillAppear:(BOOL)animated {
    
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
    PFFile *thumbnail = [object objectForKey:@"articleThumbnail"];
    PFImageView *thumbnailImageView = (PFImageView*)cell.image;
    thumbnailImageView.image = [UIImage imageNamed:@"adThumbnail"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    cell.image.layer.cornerRadius = 2;
    cell.image.clipsToBounds = YES;
    
    cell.imageBkg.layer.cornerRadius = 4;
    cell.imageBkg.clipsToBounds = YES;
    
    cell.title.text = [object objectForKey:@"articleTitle"];
    NSDate *date = object.createdAt;
    NSString *ago = [date timeAgoSinceNow];
    cell.articleDate.tag = indexPath.row;
    NSString *articleSource = [object objectForKey:@"articleSource"];
    cell.articleDate.text = [NSString stringWithFormat:@"%@ - %@",articleSource, ago];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 88;
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showNewsArticle"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; NewsDetailViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.newsArticles objectAtIndex:indexPath.row];
        NewsArticle *article = [[NewsArticle alloc] init];
        article.title = [object objectForKey:@"articleTitle"];
        article.url = [object objectForKey:@"articleUrl"];
        article.articleSource = [object objectForKey:@"articleSource"];
        
        [segue.destinationViewController setArticleUrl:article.url];
        [segue.destinationViewController setTitle:article.articleSource];
        
        destViewController.hidesBottomBarWhenPushed = YES;
     
    }
    
}


-(void)queryForNewsArticles {
    
    [ProgressHUD show:nil];
    
    PFQuery *query = [PFQuery queryWithClassName:@"NewsArticles"];
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

@end
