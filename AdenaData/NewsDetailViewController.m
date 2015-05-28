//
//  NewsDetailViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ProgressHUD show:nil];
    NSString *url = _articleUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.webview.delegate = self;
    self.webview.opaque = NO;
    
    dispatch_queue_t workerQueue = dispatch_queue_create("QueueIdentifier", NULL);
    dispatch_async(workerQueue, ^ {
        
        [self.webview loadRequest:request];
        
    });

    
    self.webview.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    
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


@end