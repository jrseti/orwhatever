//
//  ViewController.m
//  orwhatever
//
//  Created by jrichards on 7/12/13.
//  Copyright (c) 2013 MoversAndShakers.mobi. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBDialogs.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CGImage.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface ViewController ()

@end

@implementation ViewController

@synthesize pic1;
@synthesize pic2;
@synthesize connectingPic;
@synthesize imagesContainer;
@synthesize description;
@synthesize buttonOne;
@synthesize buttonTwo;
@synthesize buttonThree;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CALayer *sublayer = [self.imagesContainer layer];
    sublayer.shadowOffset = CGSizeMake(4, 4);
    sublayer.shadowRadius = 15.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 1.0;
    sublayer.borderColor = [UIColor lightGrayColor].CGColor;
    sublayer.borderWidth = 1.0;
    sublayer.cornerRadius = 20.0;
    sublayer.opacity = 5.0;
    [sublayer setMasksToBounds:NO];
    
    sublayer = [self.pic1 layer];
    sublayer.shadowOffset = CGSizeMake(4, 4);
    sublayer.shadowRadius = 14.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 1.0;
    sublayer.borderColor = [UIColor lightGrayColor].CGColor;
    sublayer.borderWidth = 1.0;
    sublayer.cornerRadius = 8.0;
    sublayer.opacity = 5.0;
    [sublayer setMasksToBounds:YES];
    
    sublayer = [self.pic2 layer];
    sublayer.shadowOffset = CGSizeMake(4, 4);
    sublayer.shadowRadius = 14.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 1.0;
    sublayer.borderColor = [UIColor lightGrayColor].CGColor;
    sublayer.borderWidth = 1.0;
    sublayer.cornerRadius = 8.0;
    sublayer.opacity = 5.0;
    [sublayer setMasksToBounds:YES];
    
    if(!IS_IPHONE_5)
    {
        CGRect f = self.buttonOne.frame;
        f.origin.y -= 25;
        self.buttonOne.frame = f;
        
        f = self.buttonTwo.frame;
        f.origin.y -= 41;
        self.buttonTwo.frame = f;
        
        f = self.buttonThree.frame;
        f.origin.y -= 58;
        self.buttonThree.frame = f;
    }
    
    NSArray *permissions =
    //[NSArray arrayWithObjects:@"email", @"user_photos", @"friends_photos", nil];
    [NSArray arrayWithObjects:@"email", nil];
    
    //[[FBSessionTokenCachingStrategy defaultInstance] clearToken];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                      // handle success + failure in block 
                                      
                                      NSLog(@"ERROR: %@", error);
                                      
                                      switch (status) {
                                          case FBSessionStateOpen:
                                              NSLog(@"FBSessionStateOpen");
                                              break;
                                          case FBSessionStateCreated:
                                              NSLog(@"FBSessionStateCreated");
                                              break;
                                          case FBSessionStateCreatedOpening:
                                              NSLog(@"FBSessionStateCreatedOpening");
                                              break;
                                          case FBSessionStateCreatedTokenLoaded:
                                              NSLog(@"FBSessionStateCreatedTokenLoaded");
                                              break;
                                          case FBSessionStateOpenTokenExtended:
                                              NSLog(@"FBSessionStateOpenTokenExtended");
                                              break;
                                          case FBSessionStateClosed:
                                              NSLog(@"FBSessionStateClosed");
                                              break;
                                          case FBSessionStateClosedLoginFailed:
                                              NSLog(@"FBSessionStateClosedLoginFailed");
                                              break;
                                          default:
                                              break;
                                      }
                                  }];


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen)
    {
        //[self populateUserDetails];
        NSLog(@"Logged in");
    }
    else
    {
        NSLog(@"NOT Logged in");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postPic:(id)sender
{
    
    if (FBSession.activeSession.isOpen)
    {
        //[self populateUserDetails];
        NSLog(@"Logged in");
    }
    else
    {
        NSLog(@"NOT Logged in");
    }

    UIImage *im = [ViewController imageWithView:self.imagesContainer];
    
    NSString *d = [[NSString alloc] initWithFormat:@"You two should %@! Or Whatever. (get the OrWhatever App)", self.description];
    BOOL displayedNativeDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
           initialText:d
           image: im
           url:[NSURL URLWithString:@"http://MoversAndShakers.mobi"]
           handler:^(FBOSIntegratedShareDialogResult result, NSError *error)
           {
               NSLog(@"RESULT=%d, %@", result, error);
           }
         ];
     
    /*

	BOOL displayedNativeDialog = [FBNativeDialogs
                                  presentShareDialogModallyFrom:self
                                  initialText:@"Hello!"
                                  image:    [UIImage imageNamed:@"BoxNWhiskers.png"]
                                  url:[NSURL URLWithString:@"http://www.example.com"]
                                  handler:^(FBNativeDialogResult result, NSError *error) {
                                      
                                      NSString *alertText = @"";
                                      if ([[error userInfo][FBErrorDialogReasonKey] isEqualToString:FBErrorDialogNotSupported]) {
                                          alertText = @"iOS Share Sheet not supported.";
                                      } else if (error) {
                                          alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
                                      } else if (result == FBNativeDialogResultSucceeded) {
                                          alertText = @"Posted successfully.";
                                      }
                                      
                                      if (![alertText isEqualToString:@""]) {
                                          // Show the result in an alert
                                          [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                      message:alertText
                                                                     delegate:self
                                                            cancelButtonTitle:@"OK!"
                                                            otherButtonTitles:nil]
                                           show];
                                      }
                                  }];
    if (!displayedNativeDialog) {
    
         Fallback to web-based Feed dialog:
         https://developers.facebook.com/docs/howtos/feed-dialog-using-ios-sdk/
         
    }
     */

}

- (IBAction)pickFriend:(id)sender
{
    // Initialize the friend picker
    FBFriendPickerViewController *friendPickerController =
    [[FBFriendPickerViewController alloc] init];
    // Set the friend picker title
    friendPickerController.title = @"Pick 2 Friends";
    friendPickerController.delegate = self;
    
    // Load the friend data
    [friendPickerController loadData];
    // Show the picker modally
    [friendPickerController presentModallyFromViewController:self animated:YES handler:nil];
}

- (IBAction)pickMatchType:(id)sender
{
 //   SelectMatchViewController *smc = [[SelectMatchViewController alloc] init];
    
    //[self.navigationController pushViewController:smc animated:YES];
}

- (void)friendPickerViewControllerSelectionDidChange:(FBFriendPickerViewController *)friendPicker
{
    int picIndex = 0;
    for (id<FBGraphUser> user in friendPicker.selection)
    {
   
        
        //NSString = user[@"picture"]["data"]["url"];
        //NSLog(@"%@", pic);
        if(picIndex == 0)
        {
            self.pic1.profileID = user[@"id"];
            CGRect f = self.pic1.frame;
            f.size.width = f.size.height;
            self.pic1.frame = f;
            CALayer *sublayer = [self.pic1 layer];
            f = sublayer.frame;
            f.size.width = f.size.height;
            sublayer.frame = f;
            NSLog(@"%f,%f", f.size.width, f.size.height);
        }
        if(picIndex == 1)
        {
            self.pic2.profileID = user[@"id"];
        }
         
        picIndex++;
    }
    
    if(friendPicker.selection.count == 2)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
            NSLog(@"DONE");

        }];
    }
}

- (IBAction)friendPicSelected:(id)sender
{
    [self pickFriend:nil];
}


/**
 * Convert a UIView into a UIImage.
 * @param view the UIView to convert.
 * @return the resulting UIImage.
 */
+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect f = view.bounds;
    f.origin.x += 10.0;
    f.origin.y += 10.0;
    f.size.width -= 20.0;
    f.size.height -= 20.0;
    
    UIImage *croppedImage = [ViewController crop:f image:img];
    
    return croppedImage;
}


+ (UIImage *)crop:(CGRect)rect image:(UIImage *)image
{
    if (image.scale > 1.0f) {
        rect = CGRectMake(rect.origin.x * image.scale,
                          rect.origin.y * image.scale,
                          rect.size.width * image.scale,
                          rect.size.height * image.scale);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}
 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController respondsToSelector:@selector(setDelegate:)])
    [segue.destinationViewController setDelegate:self];
}

- (void) complete:(NSString *)desc imageFilename:(NSString *)imageFilename
{
    if(imageFilename != nil && desc != nil)
    {
        self.connectingPic.image = [UIImage imageNamed: imageFilename];
        self.description = desc;
    }
}


@end
