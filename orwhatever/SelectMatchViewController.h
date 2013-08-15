//
//  SelectMatchViewController.h
//  orwhatever
//
//  Created by jrichards on 7/13/13.
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

//This allows informing the parent when a match image and description is selected.
@protocol SelectMatchTypeDelegate <NSObject>

@required
- (void) complete:(NSString *)description imageFilename:(NSString *)imageFilename;
@end

@interface SelectMatchViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    //id <SelectMatchTypeDelegate> delegate;
}

@property (atomic, retain) IBOutlet UIPickerView *picker;
@property (atomic, retain) IBOutlet UIButton *okButton;
@property (atomic, retain) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) NSArray *descriptions;
@property (strong, nonatomic) NSArray *imageFilenames;
@property (nonatomic, assign) id<SelectMatchTypeDelegate> delegate;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *imageFilename;

@end
