//
//  NewsArticle.h
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface NewsArticle : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) PFFile *thumbnail;
@property (nonatomic, strong) NSString *articleSource;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *url;


@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) PFFile *image;
@property (nonatomic, strong) NSString *thePost;



-(id)initWithTitle: (NSString *)title;
+(id)blogPostWithTitle: (NSString *)title;


-(NSString *)formattedDate;



@end

