//
//  ViewController.h
//  orwhatever
//
//  Created by jrichards on 7/12/13.
//  Copyright (c) 2013 MoversAndShakers.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SelectMatchViewController.h"

@interface ViewController : UIViewController <FBFriendPickerDelegate, SelectMatchTypeDelegate>

- (IBAction)postPic:(id)sender;
- (IBAction)pickFriend:(id)sender;
+ (UIImage *) imageWithView:(UIView *)view;
- (IBAction)pickMatchType:(id)sender;
+ (UIImage *)crop:(CGRect)rect image:(UIImage *)image;
- (IBAction)friendPicSelected:(id)sender;

@property (atomic, retain) IBOutlet FBProfilePictureView *pic1;
@property (atomic, retain) IBOutlet FBProfilePictureView *pic2;
@property (atomic, retain) IBOutlet UIImageView *connectingPic;
@property (atomic, retain) IBOutlet UIView *imagesContainer;
@property (atomic, retain) NSString *description;

@property (atomic, retain) IBOutlet UIButton *buttonOne;
@property (atomic, retain) IBOutlet UIButton *buttonTwo;
@property (atomic, retain) IBOutlet UIButton *buttonThree;

@end
