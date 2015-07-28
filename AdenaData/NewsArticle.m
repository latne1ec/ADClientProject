//
//  NewsArticle.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "NewsArticle.h"

@implementation NewsArticle

-(id)initWithTitle: (NSString *)title {
    
    self = [super init];
    
    if (self) {
        
        self.title = title;
        self.thumbnail = nil;
        
    }
    return self;
}

+(id) blogPostWithTitle:(NSString *)title {
    
    return [[self alloc] initWithTitle:title];
    
}

-(NSString *)formattedDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate = [formatter dateFromString:self.date];
    [formatter setDateFormat:@"EE MMM, dd"];
    return [formatter stringFromDate:tempDate];
    
}

@end
