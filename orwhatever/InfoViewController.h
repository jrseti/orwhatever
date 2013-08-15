//
//  InfoViewController.h
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

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (atomic, retain) IBOutlet UIScrollView *scrollView;
@property (atomic, retain) IBOutlet UIImageView *kidPic;
@property (atomic, retain) IBOutlet UIImageView *iosDevCampPic;

@end
