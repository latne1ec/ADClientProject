//
//  NewsDetailViewController.h
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressHUD.h"

@interface NewsDetailViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, strong) NSString *articleUrl;


@end
