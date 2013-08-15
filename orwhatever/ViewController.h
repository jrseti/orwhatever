//
//  ViewController.h
//  orwhatever
//
//  Created by jrichards on 7/12/13.
//

/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Jon Richards wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 * ----------------------------------------------------------------------------
 */

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SelectMatchViewController.h"
#import "UIViewExt.h"

@interface ViewController : UIViewController <FBFriendPickerDelegate, SelectMatchTypeDelegate>

- (IBAction)postPic:(id)sender;
- (IBAction)pickFriend:(id)sender;
- (UIImage *) imageWithView:(UIView *)view;
- (IBAction)pickMatchType:(id)sender;
+ (UIImage *)crop:(CGRect)rect image:(UIImage *)image;
- (IBAction)friendPicSelected:(id)sender;

@property (atomic, retain) IBOutlet FBProfilePictureView *pic1;
@property (atomic, retain) IBOutlet FBProfilePictureView *pic2;
@property (atomic, retain) IBOutlet UIImageView *connectingPic;
@property (atomic, retain) IBOutlet UIViewExt *imagesContainer;
@property (atomic, retain) NSString *description;

@property (atomic, retain) IBOutlet UIButton *buttonOne;
@property (atomic, retain) IBOutlet UIButton *buttonTwo;
@property (atomic, retain) IBOutlet UIButton *buttonThree;
@property (atomic, retain) IBOutlet UIButton *buttonInfo;

@property (assign) BOOL pic1Selected;
@property (assign) BOOL pic2Selected;
@property (assign) BOOL connectingPicSelected;

@end
