//
//  HomeViewController.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarController setSelectedIndex:1];
    [self loadWebpage];

    //Nav Bar Image
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adenaDataSmall"]]];
    self.navigationItem.leftBarButtonItem = item;
    
}

-(void)loadWebpage {
    
    [ProgressHUD show:nil];
    NSString *url = @"http://test.gutschy.com/";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.webview.delegate = self;
    
    dispatch_queue_t workerQueue = dispatch_queue_create("QueueIdentifier", NULL);
    dispatch_async(workerQueue, ^ {
        
        [self.webview loadRequest:request];
    });
    
    self.webview.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [ProgressHUD showError:@"Network Error"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [ProgressHUD dismiss];
}

- (IBAction)reloadPage:(id)sender {
    
    [self loadWebpage];
}
@end
