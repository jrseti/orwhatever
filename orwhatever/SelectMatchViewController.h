//
//  SelectMatchViewController.h
//  orwhatever
//
//  Created by jrichards on 7/13/13.
//  Copyright (c) 2013 MoversAndShakers.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

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
