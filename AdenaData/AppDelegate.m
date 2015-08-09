//
//  AppDelegate.m
//  AdenaData
//
//  Created by Evan Latner on 5/21/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "AppDelegate.h"
#import "AddPostTableViewController.h"
#import "CustomNavController.h"
#import "NewsTableViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AppDelegate ()



@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    //Parse Backend
    [Parse setApplicationId:@"fmyKfeKVisMjd17R32lojagYFn7NQcpYy7z9Oaqz"
                  clientKey:@"FIYdqi1M0bmswOvDyMGtUwdCjaeMThJcklHeOeBl"];
    
    //Parse Analytics
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFImageView class];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.937 green:0.416 blue:0.231 alpha:1]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.98 green:0.443 blue:0.259 alpha:1]];

    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, .0);
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:0.247 green:0.231 blue:0.227 alpha:1], NSForegroundColorAttributeName,
                                                          shadow, NSShadowAttributeName,
                                                          [UIFont fontWithName:@"AvenirNext-Medium" size:18.5], NSFontAttributeName, nil]];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    return YES;
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
   
    [PFPush handlePush:userInfo];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NotificationViewController *webview = [storyboard instantiateViewControllerWithIdentifier:@"PushWebview"];
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:webview];
    
    NSString *url = [userInfo valueForKey:@"url"];
    NSString *title = [userInfo valueForKey:@"source"];
    
    [[self window].rootViewController presentViewController:navigationController animated:YES completion:^{
       
        [webview setTitle:title];
        [webview.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [self.adnowVC queryForNewsArticles];
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
    
    
}
- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
