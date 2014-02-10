//
//  PopUpView.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 28/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASPopUpView.h"
#import "ASAppData.h"
#import "AsyncImageView.h"

@interface ASPopUpView ()

@property (weak, nonatomic) IBOutlet UIImageView *appImageView;
@property (weak, nonatomic) IBOutlet UITextView *appNameTextView;
@property (weak, nonatomic) IBOutlet UITextView *inforationTextView;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;

- (IBAction)priceButtonClicked:(id)sender;
- (IBAction)closePopUp:(id)sender;
- (IBAction)addToWishListButtonClicked:(id)sender;

@end

@implementation ASPopUpView

+ (instancetype)popUpView
{
    ASPopUpView *popUpView;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {

            popUpView = [[[NSBundle mainBundle] loadNibNamed:@"ASPopUpView_iPhone" owner:nil options:nil] objectAtIndex:0];
    }
    else
    {
        popUpView = [[[NSBundle mainBundle] loadNibNamed:@"ASPopUpView_iPad" owner:nil options:nil] objectAtIndex:0];
    }
    if ([popUpView isKindOfClass:[ASPopUpView class]])
    {
        return popUpView;
    }
    return nil;
}

- (void)animatePopUp
{
    [UIView animateWithDuration:0.3/2 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
    
    [self.delegate popUpViewDidAppear:self];
}

- (IBAction)priceButtonClicked:(id)sender
{
    [self.priceButton setTitle:ASInstallTitle forState:UIControlStateNormal];
}

- (IBAction)closePopUp:(id)sender
{
    [self.delegate dismissPopUp];
}

- (IBAction)addToWishListButtonClicked:(id)sender
{
    [self.delegate addAppToWishList];
}

- (void)configurePopUpForAppData:(ASAppData *)appData
{
    self.appImageView.imageURL = appData.imageUrl;
    
    self.appNameTextView.text = appData.appName;
    [self.priceButton setTitle:appData.price forState:UIControlStateNormal];
    self.summaryTextView.text = [NSString stringWithFormat:@"Description:\n%@",appData.summary];
    self.inforationTextView.text = [NSString stringWithFormat:@"Information\nAuthor: %@\nCategory: %@\nCopyright: %@\nRelease Date: %@",appData.authorName, appData.category, appData.copyright, appData.releaseDate];
    
    [self customizePopUpControls];
}

- (void)customizePopUpControls
{
    [self.inforationTextView setContentOffset:CGPointZero];
    [self.summaryTextView setContentOffset:CGPointZero];
    
    //set button border
    [[self.priceButton layer] setBorderWidth:2];
    [[self.priceButton layer] setBorderColor:[UIColor blueColor].CGColor];
}


@end
