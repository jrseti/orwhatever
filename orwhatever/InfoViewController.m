//
//  InfoViewController.m
//  orwhatever
//
//  Created by jrichards on 7/14/13.
//

/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Jon Richards wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "InfoViewController.h"
//#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

#define IS_RETINA ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2 )
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1400);
    
    [self addPicBorder:self.kidPic rotation:0.09f];
    //[self addPicBorder:self.iosDevCampPic rotation:-0.03f];
    //[self.iosDevCampPic.layer setBorderColor:[UIColorFromRGB(0xCCCCCC) CGColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)iosdevcampPressed:(id)sender
{
    
    CGRect f = [ [ UIScreen mainScreen ] bounds ];
    f.origin.y = self.scrollView.frame.origin.y;
    f.size.height -= f.origin.y + 20.0;
    
    self.webView = [[UIWebView alloc] initWithFrame:f];
    self.webView.alpha = 0.0;
    [self.view addSubview:self.webView];
    
    //Create a URL object.
    NSURL *thisURL = [NSURL URLWithString:@"http://www.iosdevcamp.org/2013/07/17/2013-winners/"];
    
    //URL Requst Object
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:thisURL];
    
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
    
    
    [UIView animateWithDuration:3.0 animations:^(void) {
        self.scrollView.alpha = 0.0;
        self.webView.alpha = 1.0;
    }];
    
}


- (IBAction)mandsPressed:(id)sender
{
    
    CGRect f = [ [ UIScreen mainScreen ] bounds ];
    f.origin.y = self.scrollView.frame.origin.y;
    f.size.height -= f.origin.y + 20.0;
    
    self.webView = [[UIWebView alloc] initWithFrame:f];
    self.webView.alpha = 0.0;
    [self.view addSubview:self.webView];
    
    //Create a URL object.
    NSURL *thisURL = [NSURL URLWithString:@"http://moversandshakers.mobi"];
    
    //URL Requst Object
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:thisURL];
    
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
    
    
    [UIView animateWithDuration:3.0 animations:^(void) {
        self.scrollView.alpha = 0.0;
        self.webView.alpha = 1.0;
    }];

}

-(void)addPicBorder:(UIImageView *)imageView rotation:(float)rotation
{
    float scale = [[UIScreen mainScreen] scale]*1.5;
    
    if(IS_RETINA)
    {
        scale *=0.75;
    }
    [imageView.layer setBorderWidth:5.0f*scale];
    
    
    [imageView.layer setBorderColor:[UIColorFromRGB(0xEEEEEE) CGColor]];
    [imageView.layer setShadowRadius:5.0f*scale];
    [imageView.layer setShadowOpacity:.85f];
    [imageView.layer setShadowOffset:CGSizeMake(1.0f*scale, 2.0f*scale)];
    [imageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [imageView.layer setShouldRasterize:YES];
    [imageView.layer setMasksToBounds:NO];
    CGAffineTransform transform = CGAffineTransformMakeRotation(rotation);
    imageView.transform = transform;
}


@end
