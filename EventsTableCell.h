//
//  EventsTableCell.h
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface EventsTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *image;

@property (weak, nonatomic) IBOutlet UIImageView *imageBkg;
@property (weak, nonatomic) IBOutlet UIImageView *tableCellFade;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;

@end
