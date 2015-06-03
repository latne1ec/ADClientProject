//
//  NotificationViewController.h
//  AdenaData
//
//  Created by Evan Latner on 6/1/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressHUD.h"

@interface NotificationViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, weak) NSString *articleUrl;
@property (nonatomic, weak) NSString *articleSource;


-(void)handleIncomingPushNotification:(NSDictionary *)userInfo;

- (IBAction)popHome:(id)sender;


@end
