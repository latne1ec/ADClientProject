//
//  AddPostTableViewController.h
//  AdenaData
//
//  Created by Evan Latner on 7/15/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "ProgressHUD.h"

@interface AddPostTableViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *thirdCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *fourthCell;

@property (weak, nonatomic) IBOutlet UITextField *titleTextfield;
@property (weak, nonatomic) IBOutlet UITextField *locationTextfield;
@property (weak, nonatomic) IBOutlet UITextView *postTextview;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thePhoto;

@property (weak, nonatomic) IBOutlet UIImageView *addPhotoPic;

@property (nonatomic, strong) UIImage *thumbnail;


@property (nonatomic, strong) PFFile *filePic2;

@property (nonatomic, strong) UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



- (IBAction)showActionSheet:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;



@end
