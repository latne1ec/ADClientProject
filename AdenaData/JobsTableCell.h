//
//  JobsTableCell.h
//  AdenaData
//
//  Created by Evan Latner on 5/26/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobsTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLocation;
@property (weak, nonatomic) IBOutlet UILabel *jobDateLabel;

@end
