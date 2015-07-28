//
//  AddPostTableViewController.m
//  AdenaData
//
//  Created by Evan Latner on 7/15/15.
//  Copyright (c) 2015 AdenaData. All rights reserved.
//

#import "AddPostTableViewController.h"
#import "JGActionSheet.h"
#define SOURCETYPE UIImagePickerControllerSourceTypeCamera


@interface AddPostTableViewController () <JGActionSheetDelegate> {
    JGActionSheet *_currentAnchoredActionSheet;
    UIView *_anchorView;
    BOOL _anchorLeft;
    JGActionSheet *_simple;
}



@end

@implementation AddPostTableViewController

#define iOS7 (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0)
#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@synthesize firstCell, secondCell, thirdCell, fourthCell;


- (BOOL) shouldAutorotate {
    return YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.title = @"Add Post";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:(UIImage *) [[UIImage imageNamed:@"cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismissViewControllerAnimated:completion:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(sharePost)];
    
    self.titleTextfield.delegate = self;
    self.locationTextfield.delegate = self;
    self.postTextview.delegate = self;
    
    self.thePhoto.clipsToBounds = YES;
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.layer.masksToBounds = YES;
    self.tableView.clipsToBounds = YES;
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(50.0, 0.0, (keyboardSize.height), 0.0);
    }
    
    self.tableView.contentInset = contentInsets;
    //self.tableView.scrollIndicatorInsets = contentInsets;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
//    self.tableView.contentInset = UIEdgeInsetsZero;
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
//    
//    [self.tableView setContentInset:UIEdgeInsetsZero];

    self.tableView.contentInset = UIEdgeInsetsMake(50,0,0,0);
}


-(void)viewWillAppear:(BOOL)animated {
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField; {
    
    if([self.titleTextfield isFirstResponder]){
        [self.locationTextfield becomeFirstResponder];
    }
    else if ([self.locationTextfield isFirstResponder]){
        
        [self.postTextview resignFirstResponder];
        [self.postTextview performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0];
        
    }
    else if ([self.postTextview isFirstResponder]){
        
        [self.postTextview resignFirstResponder];
        
    }
    return YES;
}

- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text {
    
    if ([text length] > 1) {
        
        self.placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


// Custom Placeholder
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderLabel.hidden = NO;
    
    if ([textView.text length] > 0) {
        self.placeholderLabel.hidden = YES;
    }
}
- (void)textViewDidChange:(UITextView *)txtView {
    self.placeholderLabel.hidden = ([txtView.text length] > 0);
}

- (void)textViewDidEndEditing:(UITextView *)txtView {
    self.placeholderLabel.hidden = ([txtView.text length] > 0);
}

-(void)dismissKeyboard {
    
    [self.titleTextfield resignFirstResponder];
    [self.locationTextfield resignFirstResponder];
    [self.postTextview resignFirstResponder];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) return firstCell;
    if (indexPath.row == 1) return secondCell;
    if (indexPath.row == 2) return thirdCell;
    if (indexPath.row == 3) return fourthCell;
    
    return nil;
}

//*********************************************
// Present Action Sheet To Take Photo

- (IBAction)showActionSheet:(UIView *)anchor {
    
    [self dismissKeyboard];
    
    if (!_simple) {
        
        _simple = [JGActionSheet actionSheetWithSections:@[[JGActionSheetSection sectionWithTitle:@"Add Picture" message:@"" buttonTitles:@[@"Take Photo", @"Choose From Library"] buttonStyle:JGActionSheetButtonStyleDefault]]];
        _simple.delegate = self;
        _simple.insets = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
        [_simple setOutsidePressBlock:^(JGActionSheet *sheet) {
            [sheet dismissAnimated:YES];
            
        }];
        
        __unsafe_unretained typeof(self) weakSelf = self;
        
        [_simple setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
            
            if (indexPath.row == 0) {
                
                if ([UIImagePickerController isSourceTypeAvailable:SOURCETYPE]) {
                    
                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                    picker.delegate = weakSelf;
                    picker.allowsEditing = YES;
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [weakSelf presentViewController:picker animated:YES completion:NULL];
                    [sheet dismissAnimated:NO];
                    
                }
                else {
                    //Cannot Take Photo -- Capturing photo's is not supported
                    //[sheet dismissAnimated:YES];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Not Available" message:@"Choose a photo from your library instead." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    
                }
                
            }
            if (indexPath.row == 1) {
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = weakSelf;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [weakSelf presentViewController:picker animated:YES completion:^{
                    
                }];
                [sheet dismissAnimated:NO];
            }
        }];
    }
    
    if (anchor && iPad) {
        _anchorView = anchor;
        _anchorLeft = YES;
        _currentAnchoredActionSheet = _simple;
        CGPoint p = (CGPoint){-5.0f, CGRectGetMidY(anchor.bounds)};
        p = [self.navigationController.view convertPoint:p fromView:anchor];
        [_simple showFromPoint:p inView:[[UIApplication sharedApplication] keyWindow] arrowDirection:JGActionSheetArrowDirectionRight animated:YES];
    }
    else {
        [_simple showInView:self.navigationController.view animated:YES];
    }
}
//*********************************************

//*********************************************
// User Finished Taking Photo

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //UIControl *sender = [[UIControl alloc] init];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    //if (image.size.width > 140) image = ResizeImage2(image, 140, 140);
    
    PFFile *filePicture = [PFFile fileWithName:@"picture.png" data:UIImagePNGRepresentation(image)];
    [filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        //if (error != nil) [ProgressHUD showError:@"Network error."];
    }];
    
    self.thePhoto.image = image;
    self.thumbnail = image;
    
    self.addPhotoPic.hidden = YES;
    
    if (self.thumbnail.size.width > 140) image = ResizeImage2(self.thumbnail, 140, 140);
    
    self.filePic2 = [PFFile fileWithName:@"picture.png" data:UIImagePNGRepresentation(image)];
    [self.filePic2 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];

    
    [picker dismissViewControllerAnimated:NO completion:NULL];
}
//*********************************************


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    self.addPhotoPic.hidden = NO;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];

}


//*********************************************
// Resize the Image

UIImage* ResizeImage2(UIImage *image, CGFloat width, CGFloat height) {
    
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//*********************************************


-(void)sharePost {
    
    [self dismissKeyboard];
    
    NSString *title = self.titleTextfield.text;
    NSString *location = self.locationTextfield.text;
    NSString *postText = self.postTextview.text;

    if ([title length] < 2) {
     
        [ProgressHUD showError:@"Please enter a title"];
    }
    else if ([location length] < 2) {
        [ProgressHUD showError:@"Please enter a location"];
    }
    else if ([postText length] < 2) {
        [ProgressHUD showError:@"Please enter a post"];
    }
    
    else {
        
        if (self.thePhoto.image == nil) {
            self.thePhoto.image = [UIImage imageNamed:@"adThumbnail.jpeg"];
        }
        
    [ProgressHUD show:nil Interaction:NO];
    self.addPhotoPic.hidden = YES;
    PFFile *file = [PFFile fileWithName:@"picture.png" data:UIImagePNGRepresentation(self.thePhoto.image)];
    self.filePic2 = [PFFile fileWithName:@"picture.png" data:UIImagePNGRepresentation(self.thePhoto.image)];
    

    PFObject *post = [PFObject objectWithClassName:@"Posts"];
    [post setObject:title forKey:@"postTitle"];
    [post setObject:file forKey:@"postImage"];
    [post setObject:self.filePic2 forKey:@"postImageThumbnail"];
    [post setObject:location forKey:@"postLocation"];
    [post setObject:postText forKey:@"postText"];
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
       
        if (error) {
            
            [ProgressHUD showError:@"Network Error"];
        }
        else {
            [ProgressHUD dismiss];
            [ProgressHUD showSuccess:@"Shared Post"];
            [self dismissKeyboard];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];
    }
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    
    [self dismissKeyboard];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
