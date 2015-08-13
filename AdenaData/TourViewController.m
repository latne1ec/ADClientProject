//
//  TourViewController.m
//  Stockd
//
//  Created by Carlos on 7/1/15.
//  Copyright (c) 2015 Stockd. All rights reserved.
//

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#import "TourViewController.h"
#import "NewsTableViewController.h"

@interface TourViewController()
@property(nonatomic,strong) UIScrollView *pagedTour;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic) int pages;
@property(nonatomic) float w, h;
@end

@implementation TourViewController



-(void)viewDidLoad
{
    
    _w = self.view.frame.size.width;
    _h = self.view.frame.size.height;
    
    UIView *whiteSquare = [[UIView alloc] initWithFrame:CGRectMake(0, _h/2.0f, _w, _h/2.0f)];
    whiteSquare.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteSquare];
    
    
    _pages = 4;
    _pagedTour = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _pagedTour.contentSize = CGSizeMake(_pagedTour.frame.size.width*_pages, _pagedTour.frame.size.height);
    _pagedTour.showsHorizontalScrollIndicator = NO;
    _pagedTour.showsVerticalScrollIndicator = NO;
    _pagedTour.delegate = self;
    _pagedTour.bounces = YES;
    _pagedTour.pagingEnabled = YES;
    _pagedTour.contentSize = CGSizeMake(_pagedTour.contentSize.width,_pagedTour.frame.size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_pagedTour];
    
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Medium" size:20.];
    NSString *message1 = @"See what's happening all around you within the next 24 hours!";
    NSString *message2 = @"Check out some up and coming events.";
    NSString *message3 = @"Looking for a job where you fit? Let AD Jobs Help!";
    //NSString *message4 = @"THAT'S IT!\n#GETSTOCKD";
    
    UIImage *image1 = [UIImage imageNamed:@"tour1.png"];
    UIImage *image2 = [UIImage imageNamed:@"tour2.png"];
    UIImage *image3 = [UIImage imageNamed:@"tour3.png"];
    
   // NSString *thankYouMessage = @"THANK YOU!\nYOU'LL BE NOTIFIED WHEN YOUR DELIVERY IS ON THE WAY!";
    
    UIView *page1 = [[UIView alloc] initWithFrame:self.view.bounds];
    page1.backgroundColor = [UIColor clearColor];
    [_pagedTour addSubview:page1];
    
    float maxWidth = _w;
    float scaleTo = maxWidth/[image1 size].width;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_w/2.0f-([image1 size].width*scaleTo)/2.0f, ((_h/2.0f)-([image1 size].height*scaleTo)), ([image1 size].width*scaleTo), ([image1 size].height*scaleTo))];
    imageView1.backgroundColor = [UIColor clearColor];
    imageView1.image = image1;
    [page1 addSubview:imageView1];
    
    
    UILabel *page1Message = [[UILabel alloc] initWithFrame:CGRectMake(75, _h/2.0f, _w-150, _h/2.2f)];
    page1Message.text = message1;
    page1Message.numberOfLines = 0;
    page1Message.font = font;
    page1Message.textColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    page1Message.textAlignment = NSTextAlignmentCenter;
    [page1 addSubview:page1Message];
    
    UIView *page2 = [[UIView alloc] initWithFrame:CGRectMake(_w, 0, _w, _h)];
    page2.backgroundColor = [UIColor clearColor];
    [_pagedTour addSubview:page2];
    
    scaleTo = maxWidth/[image2 size].width;
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(_w/2.0f-([image2 size].width*scaleTo)/2.0f, ((_h/2.0f)-([image2 size].height*scaleTo)), ([image2 size].width*scaleTo), ([image2 size].height*scaleTo))];
    imageView2.backgroundColor = [UIColor clearColor];
    imageView2.image = image2;
    [page2 addSubview:imageView2];
    
    whiteSquare = [[UIView alloc] initWithFrame:CGRectMake(0, _h/2.0f, _w, _h/2.0f)];
    whiteSquare.backgroundColor = [UIColor whiteColor];
    [page2 addSubview:whiteSquare];
    
    UILabel *page2Message = [[UILabel alloc] initWithFrame:CGRectMake(75, _h/2.0f, _w-150, _h/2.2f)];
    page2Message.text = message2;
    page2Message.numberOfLines = 0;
    page2Message.font = font;
    page2Message.textColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    page2Message.textAlignment = NSTextAlignmentCenter;
    [page2 addSubview:page2Message];
    
    UIView *page3 = [[UIView alloc] initWithFrame:CGRectMake(_w*2, 0, _w, _h)];
    page3.backgroundColor = [UIColor clearColor];
    [_pagedTour addSubview:page3];
    
    scaleTo = maxWidth/[image3 size].width;
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(_w/2.0f-([image3 size].width*scaleTo)/2.0f, ((_h/2.0f)-([image3 size].height*scaleTo)), ([image3 size].width*scaleTo), ([image3 size].height*scaleTo))];
    imageView3.backgroundColor = [UIColor clearColor];
    imageView3.image = image3;
    [page3 addSubview:imageView3];
    
    whiteSquare = [[UIView alloc] initWithFrame:CGRectMake(0, _h/2.0f, _w, _h/2.0f)];
    whiteSquare.backgroundColor = [UIColor whiteColor];
    [page3 addSubview:whiteSquare];
    
    UILabel *page3Message = [[UILabel alloc] initWithFrame:CGRectMake(75, _h/2.0f, _w-150, _h/2.2f)];
    page3Message.text = message3;
    page3Message.numberOfLines = 0;
    page3Message.font = font;
    page3Message.textColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    page3Message.textAlignment = NSTextAlignmentCenter;
    [page3 addSubview:page3Message];
    
    UIView *page4 = [[UIView alloc] initWithFrame:CGRectMake(_w*3, 0, _w, _h)];
    page4.backgroundColor = [UIColor clearColor];
    //page4.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"adBkgAug.png"]];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:page4.bounds];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"adBkgAug.png"]];
    [page4 addSubview:imageview];
    [_pagedTour addSubview:page4];
    
    whiteSquare = [[UIView alloc] initWithFrame:CGRectMake(0, _h/2.0f, _w, _h/2.0f)];
    whiteSquare.backgroundColor = [UIColor whiteColor];
    //[page4 addSubview:whiteSquare];
    
    UILabel *page4Message = [[UILabel alloc] initWithFrame:CGRectMake(75, _h/2.0f-_h/10.0f, _w-150, _h/2.0f)];
    //page4Message.text = message4;
    page4Message.numberOfLines = 0;
    page4Message.font = font;
    page4Message.textColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    page4Message.textAlignment = NSTextAlignmentCenter;
    [page4 addSubview:page4Message];
    
    UILabel *page4ThankYou = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, _w-150, _h/2.0f)];
    //page4ThankYou.text = thankYouMessage;
    page4ThankYou.numberOfLines = 0;
    page4ThankYou.font = font;
    page4ThankYou.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    page4ThankYou.textAlignment = NSTextAlignmentCenter;
    [page4 addSubview:page4ThankYou];
    
    
    float buttonWidth = _w*0.70f;
    float buttonHeight = 45.0f;
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    startButton.backgroundColor = [UIColor colorWithRed:0.937 green:0.416 blue:0.231 alpha:1];
    startButton.frame = CGRectMake(_w/2.0f-buttonWidth/2.0f, _h/1.60f+[self compare:80], buttonWidth, buttonHeight);
    [startButton addTarget:self action:@selector(getStarted:) forControlEvents:UIControlEventTouchUpInside];
    [page4 addSubview:startButton];
    
    UILabel *buttonLabel = [[UILabel alloc] initWithFrame:startButton.bounds];
    buttonLabel.text = @"Continue";
    buttonLabel.numberOfLines = 0;
    buttonLabel.font = font;
    buttonLabel.userInteractionEnabled = NO;
    buttonLabel.textColor = [UIColor whiteColor];
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    [startButton addSubview:buttonLabel];
    
    UILabel *terms = [[UILabel alloc] initWithFrame:CGRectMake(_w/2.0f-buttonWidth/2.0f, _h/1.44f+[self compare:80], buttonWidth, buttonHeight)];
    terms.text = @"By continuing, you agree to our";
    terms.numberOfLines = 0;
    terms.font = [UIFont fontWithName:@"AvenirNext-Medium" size:13];
    terms.userInteractionEnabled = NO;
    terms.textColor = [UIColor colorWithWhite:1.0 alpha:0.93];
    terms.textAlignment = NSTextAlignmentCenter;
    [page4 addSubview:terms];
    
    UIButton *termsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    termsButton.frame = CGRectMake(_w/2.0f-buttonWidth/2.0f, _h/1.37f+[self compare:80], buttonWidth, buttonHeight);
    [termsButton setTitle:@"terms and privacy policy" forState:UIControlStateNormal];
    termsButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:13];
    termsButton.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.93];
    termsButton.backgroundColor = [UIColor clearColor];
    [termsButton addTarget:self action:@selector(linkToTerms) forControlEvents:UIControlEventTouchUpInside];
    [page4 addSubview:termsButton];
    
    
    CALayer *btn1 = [startButton layer];
    [btn1 setMasksToBounds:YES];
    [btn1 setCornerRadius:5.0f];
    //[btn1 setBorderWidth:1.5f];
    //[btn1 setBorderColor:UIColorFromRGB(0x00E676).CGColor];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _h-80, _w, 80)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _pages;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.2f];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.5f];
    [self.view addSubview:_pageControl];
    
    
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)linkToTerms {
    
    NSLog(@"Terms");
    NSURL *url = [NSURL URLWithString:@"http://www.adenadata.com/terms.html"];
    [[UIApplication sharedApplication] openURL:url];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [self.navigationController.navigationBar setHidden:NO];

}

-(float)compare:(float)cual
{
    return (self.view.frame.size.height/685)*cual;
}

-(IBAction)getStarted:(id)sender
{
    NSLog(@"GET STARTED!");
    
    [PFUser enableAutomaticUser];
    [[PFUser currentUser] saveInBackground];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"hasRanApp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    CATransition *transition = [CATransition animation];
    [transition setType:kCATransitionFade];
    [self.navigationController.view.layer addAnimation:transition forKey:@"someAnimation"];
    
    NewsTableViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"Posts"];
    ivc.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:ivc animated:NO];
    [CATransaction commit];

}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

@end
