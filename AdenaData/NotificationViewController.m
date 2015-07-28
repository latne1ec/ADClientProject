//
//  NotificationViewController.m
//  AdenaData
//
//  Created by Evan Latner on 6/1/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ProgressHUD show:nil];
    
    self.webview.delegate = self;
    self.webview.opaque = YES;
    self.webview.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
}

-(void)viewDidAppear:(BOOL)animated {
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [ProgressHUD dismiss];
    [self.webview stopLoading];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //[ProgressHUD showError:@"Network Error"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [ProgressHUD dismiss];
}

- (IBAction)popHome:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
       
    }];
}

-(void)handleIncomingPushNotification:(NSDictionary *)userInfo {

}
@end
