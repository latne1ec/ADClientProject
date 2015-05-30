//
//  Job.h
//  AdenaData
//
//  Created by Evan Latner on 5/26/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Job : NSObject

@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) NSString *jobEmployer;
@property (nonatomic, strong) NSString *jobLocation;
@property (nonatomic, strong) NSString *jobLink;
@property (nonatomic, strong) NSDate *jobDate;
@property (nonatomic, copy) NSString *positionDetails;
@property (nonatomic, copy) NSString *requirements;



@end
