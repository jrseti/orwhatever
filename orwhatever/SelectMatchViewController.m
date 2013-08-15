//
//  SelectMatchViewController.m
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

#import "SelectMatchViewController.h"
#import "AppDelegate.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//This allows informing the parent when a match image and description is selected.
@interface SelectMatchViewController ()

@end

@implementation SelectMatchViewController

@synthesize picker;
@synthesize okButton;
@synthesize descriptions;
@synthesize imageFilenames;
@synthesize delegate;
@synthesize description;
@synthesize imageFilename;
@synthesize iconView;

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
	
    //Define the images and the descriptions
    self.descriptions = [[NSArray alloc] initWithObjects:
                         @"get together",
                         @"fall in love",
                         @"go to a movie",
                         @"go out for coffee",
                         @"go out for dinner",
                         @"go on a run",
                         @"go fishing",
                         @"share music",
                         @"read a book",
                         @"walk dogs",
                         @"work out",
                         @"go to Las Vegas",
                         @"go for a bike ride",
                         @"chat on Skype",
                         @"chat on Facebook",
                         @"Email",
                         nil];
    
    self.imageFilenames = [[NSArray alloc]
                          initWithObjects:
                            @"29-heart.png",
                            @"29-heart.png",
                            @"45-movie-1.png",
                            @"34-coffee.png",
                            @"109-chicken.png",
                            @"63-runner.png",
                            @"glyphicons_254_fishes.png",
                            @"65-note.png",
                            @"96-book.png",
                            @"82-dog-paw.png",
                            @"glyphicons_356_dumbbell.png",
                            @"130-dice.png",
                            @"glyphicons_306_bicycle.png",
                            @"glyphicons_418_skype.png",
                            @"glyphicons_410_facebook.png",
                            @"glyphicons_419_e-mail.png",
                            nil];
    
   // [self.picker selectRow:0 inComponent:0 animated:NO];
    
    self.iconView.image = [UIImage imageNamed: [self.imageFilenames objectAtIndex:0]];
    self.description = [self.descriptions objectAtIndex:0];
    self.imageFilename = [self.imageFilenames objectAtIndex:0];
    
    if(!IS_IPHONE_5)
    {
        CGRect f = self.okButton.frame;
        f.origin.y -= 20;
        self.okButton.frame = f;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okButtonPressed:(id)sender
{
    //Tell the parent what was selected.
    [self.delegate complete:self.description imageFilename:self.imageFilename];
    
    //Flip back
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.descriptions count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.descriptions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.description = [self.descriptions objectAtIndex:row];
    self.imageFilename = [self.imageFilenames objectAtIndex:row];
    self.iconView.image = [UIImage imageNamed: self.imageFilename];
}

@end
