//
//  WelcomeViewController.h
//  AdenaData
//
//  Created by Evan Latner on 7/16/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WelcomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

- (IBAction)continueTapped:(id)sender;
- (IBAction)termsLink:(id)sender;

@end
