//
//  Event.h
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) PFFile *thumbnail;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *eventDescription;

@end
