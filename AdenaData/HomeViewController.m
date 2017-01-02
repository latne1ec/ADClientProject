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
    
    
    CALayer *btn1 = [self.visitWebsiteButton layer];
    [btn1 setMasksToBounds:YES];
    [btn1 setCornerRadius:5.0f];
    
    
    self.twitterButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.twitterButton.layer.shadowOpacity = 0.24;
    self.twitterButton.layer.shadowRadius = 1.95;
    self.twitterButton.layer.shadowOffset = CGSizeMake(1.95f, 1.95f);

    self.websiteButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.websiteButton.layer.shadowOpacity = 0.24;
    self.websiteButton.layer.shadowRadius = 1.95;
    self.websiteButton.layer.shadowOffset = CGSizeMake(1.95f, 1.95f);
    
    self.facebookButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.facebookButton.layer.shadowOpacity = 0.24;
    self.facebookButton.layer.shadowRadius = 1.95;
    self.facebookButton.layer.shadowOffset = CGSizeMake(1.95f, 1.95f);
    
    
    [self.twitterButton addTarget:self action:@selector(goToTwitter) forControlEvents:UIControlEventTouchUpInside];
    [self.websiteButton addTarget:self action:@selector(goToWebsite) forControlEvents:UIControlEventTouchUpInside];
    [self.facebookButton addTarget:self action:@selector(goToFacebook) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadWebpage {
    
    [ProgressHUD show:nil];
    NSString *url = @"http://www.adenadata.com";
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

- (IBAction)visitWebsiteTapped:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://adenadata.com"]];
}

- (IBAction)reloadPage:(id)sender {
    
    [self loadWebpage];
}

-(void)goToTwitter {
    
    NSURL *url = [NSURL URLWithString:@"https://twitter.com/AdenaDataLLC"];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)goToWebsite {
    
    NSURL *url = [NSURL URLWithString:@"http://www.adenadata.com/"];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)goToFacebook {
    
    NSURL *url = [NSURL URLWithString:@"https://www.facebook.com/749695621773532"];
    [[UIApplication sharedApplication] openURL:url];
}


@end
