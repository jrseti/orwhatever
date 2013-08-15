//
//  UIViewExt.m
//  orwhatever
//
//  Created by jrichards on 7/29/13.
//

/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * Jon Richards wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 * ----------------------------------------------------------------------------
 */

#import "UIViewExt.h"
#import "UIViewExt.h"

#define IS_RETINA ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2 )

//This class is used to enable drawing a gray line inside the border.
//I had to subclass to do this.
@implementation UIViewExt

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    float scale = [[UIScreen mainScreen] scale]*1.5;
    
    if(IS_RETINA)
    {
        scale *=0.75;
    }

    
   // Draw a light gray rectangle inside the boder where it meets the picture.
   CGContextRef ctx = UIGraphicsGetCurrentContext(); //get the graphics context
   CGContextSetRGBStrokeColor(ctx, 0.8, 0.8, 0.8, 1); //there are two relevant color states, "Stroke" -- used in Stroke drawing
   CGRect r = CGRectMake(5.0f*scale+1, 5.0f*scale+1, self.frame.size.width-10.0f*scale-8,
                             self.frame.size.height-10.0f*scale-10);
   CGContextAddRect(ctx, r);
    
   CGContextStrokePath(ctx);
}


@end
