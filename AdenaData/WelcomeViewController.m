//
//  WelcomeViewController.m
//  AdenaData
//
//  Created by Evan Latner on 7/16/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (BOOL) shouldAutorotate {
    return NO;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
           return UIInterfaceOrientationPortrait;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *btn1 = [self.continueButton layer];
    [btn1 setMasksToBounds:YES];
    [btn1 setCornerRadius:5.0f];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (IBAction)continueTapped:(id)sender {

    [PFUser enableAutomaticUser];
    [[PFUser currentUser] saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)termsLink:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://www.adenadata.com/terms.html"];
    
    [[UIApplication sharedApplication] openURL:url];
}
@end
