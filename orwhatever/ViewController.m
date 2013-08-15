//
//  ViewController.m
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

#import "ViewController.h"
#import "UIViewExt.h"
#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBDialogs.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CGImage.h>
#import <QuartzCore/QuartzCore.h>

//Macros. I know - some people think macros are evil. But these few save me a lot of time.
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_RETINA ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2 )
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//This is the main view controller
@implementation ViewController

@synthesize pic1;
@synthesize pic2;
@synthesize connectingPic;
@synthesize imagesContainer;
@synthesize description;
@synthesize buttonOne;
@synthesize buttonTwo;
@synthesize buttonThree;
@synthesize buttonInfo;
@synthesize pic1Selected;
@synthesize pic2Selected;
@synthesize connectingPicSelected;


//Init the main view - create all the UI elements.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pic1Selected = NO;
    self.pic2Selected = NO;
    self.connectingPicSelected = NO;
    
    //Create the main picture view, with a border to look like a Poloroid.
    [self addViewBorder:self.imagesContainer rotation:0.03f];
    
    //Create the two Facebook image views. Gice them round corners.
    CALayer *sublayer = [self.pic1 layer];
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
    
    //Shift things around a bit to make this UI look perfect on an iPhone4
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
        
        f = self.buttonInfo.frame;
        f.origin.y -= 75;
        self.buttonInfo.frame = f;
    }
    
    //Log into Facebook. uses the Native Facebook SDK.
    NSArray *permissions = [NSArray arrayWithObjects:@"email", nil];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                      // handle success + failure in block 
                                      
                                      NSLog(@"ERROR: %@", error);
                                      
                                      if(error != nil)
                                      {
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Facebook Login Error"
                                                                                      message: @"There was an error logging into Facebook! Sorry!"
                                                                                     delegate: nil
                                                                            cancelButtonTitle:@"OK"
                                                                            otherButtonTitles:nil];
                                          [alert show];
                                      }
            
                                      
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
    
    //Used for debugging only. Leaving in just in case I need to debug logging into Facebook again.
    /*
    if (FBSession.activeSession.isOpen)
    {
        NSLog(@"Logged in");
    }
    else
    {
        NSLog(@"NOT Logged in");
    }
     */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Post the picture to Facebook
- (IBAction)postPic:(id)sender
{
    if(self.pic1Selected != YES || self.pic2Selected != YES || self.connectingPicSelected != YES)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Facebook Post Error"
                                                        message: @"You need to select 2 Facebook friends and a match up type. Try again!"
                                                       delegate: nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (FBSession.activeSession.isOpen)
    {
        NSLog(@"Logged in");
    }
    else
    {
        NSLog(@"NOT Logged in");
    }

    UIImage *im = [self imageWithView:self.imagesContainer];
    
    NSString *d = [[NSString alloc] initWithFormat:@"You two should %@! Or Whatever. (get the OrWhatever App)", self.description];
    //Present the Facbook post dialog. Only post if user selected to do so.
    //Show appropriate messages if it works or if it does not.
    [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
           initialText:d
           image: im
           url:[NSURL URLWithString:@"http://MoversAndShakers.mobi"]
           handler:^(FBOSIntegratedShareDialogResult result, NSError *error)
           {
               if(error != nil)
               {
                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Facebook Post Error"
                                                               message: @"There was an error posting to Facebook! Sorry!"
                                                              delegate: nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                   [alert show];
               }
               else
               {
                   if(result == FBOSIntegratedShareDialogResultSucceeded)
                   {
                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Facebook Post Success"
                                                                   message: @"Your post to Facebook was successful."
                                                                  delegate: nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
                       [alert show];
                   }
                   else if(result == FBOSIntegratedShareDialogResultCancelled)
                   {
                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Facebook Post Cancelled"
                                                                       message: @"Don't worry! Your post to Facebook was cancelled."
                                                                      delegate: nil
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
                       [alert show];
                   }
                   else
                   {
                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error! Facebook Post Failed"
                                                                       message: @"Your post to Facebook was cancelled."
                                                                      delegate: nil
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
                       [alert show];
                   }

               }
           }
         ];

}

//Display the facebook friend picker.
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

//Display the screen to allo the user to select a matchup activity type.
- (IBAction)pickMatchType:(id)sender
{
 //   SelectMatchViewController *smc = [[SelectMatchViewController alloc] init];
    
    //[self.navigationController pushViewController:smc animated:YES];
}

//This is a callback that gets the 2 facebook friends selected.
- (void)friendPickerViewControllerSelectionDidChange:(FBFriendPickerViewController *)friendPicker
{
    int picIndex = 0;
    for (id<FBGraphUser> user in friendPicker.selection)
    {
   
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
            
            self.pic1Selected = YES;
        }
        if(picIndex == 1)
        {
            self.pic2.profileID = user[@"id"];
            self.pic2Selected = YES;
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
- (UIImage *) imageWithView:(UIView *)view
{

    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect f = view.frame;
    f.origin.x -= 5.0;
    f.origin.y -= 5.0;
    f.size.width += 10.0;
    f.size.height += 10.0;
    
    UIImage *croppedImage = [ViewController crop:f image:img];
    
    return croppedImage;

}

//Crop an image returning another image as the result.
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
 
//When transferring to another view - tell that view that this is the delegate.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController respondsToSelector:@selector(setDelegate:)])
    [segue.destinationViewController setDelegate:self];
}

//Callback that receives the selected matchup image filename and description.
- (void) complete:(NSString *)desc imageFilename:(NSString *)imageFilename
{
    if(imageFilename != nil && desc != nil)
    {
        self.connectingPic.image = [UIImage imageNamed: imageFilename];
        self.description = desc;
        self.connectingPicSelected = YES;
    }
}

//Add a border to a view soit looks like a photograph, and rotate it.
-(void)addViewBorder:(UIViewExt *)view rotation:(float)rotation
{
    float scale = [[UIScreen mainScreen] scale]*1.5;
    
    if(IS_RETINA)
    {
        scale *=0.75;
    }
    [view.layer setBorderWidth:5.0f*scale];
    
    
    [view.layer setBorderColor:[UIColorFromRGB(0xEEEEEE) CGColor]];
    [view.layer setShadowRadius:5.0f*scale];
    [view.layer setShadowOpacity:.85f];
    [view.layer setShadowOffset:CGSizeMake(1.0f*scale, 2.0f*scale)];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShouldRasterize:YES];
    [view.layer setMasksToBounds:NO];
    CGAffineTransform transform = CGAffineTransformMakeRotation(rotation);
    view.transform = transform;
    
    [view setNeedsDisplay];
    
}



@end
