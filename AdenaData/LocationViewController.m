//
//  LocationViewController.m
//  AdenaData
//
//  Created by Evan Latner on 7/30/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "LocationViewController.h"
#import "ProgressHUD.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.searchString;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:(UIImage *) [[UIImage imageNamed:@"cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismissViewControllerAnimated:completion:)];
    
    self.webview.delegate = self;
    self.webview.opaque = YES;
    self.webview.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    

    NSString *string = [self.searchString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"String: %@", string);
    
    
    NSString *search = [NSString stringWithFormat:@"https://www.google.com/#q=%@", string];
    
    //NSURL * url = [NSURL URLWithString: [NSString stringWithFormat: @ "http://www.google.com/search?q =%@", self.searchString]];
    
    NSString *finalString = [search stringByReplacingOccurrencesOfString:@" " withString: @"+"];

    
    
    
    
    NSURL *url = [NSURL URLWithString:finalString];
    
    NSLog(@"Search: %@", url);

    
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
    
    
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
    
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
    NSLog(@"Error: %@", error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [ProgressHUD dismiss];
}


@end
