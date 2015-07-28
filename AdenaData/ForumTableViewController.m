//
//  ForumTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 7/15/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "ForumTableViewController.h"

@interface ForumTableViewController ()

@end

@implementation ForumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // Configure the cell...
    
    return cell;
}


@end
