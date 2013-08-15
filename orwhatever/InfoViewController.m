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
