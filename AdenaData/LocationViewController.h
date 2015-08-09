//
//  LocationViewController.h
//  AdenaData
//
//  Created by Evan Latner on 7/30/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, strong) NSString *searchString;


@end
