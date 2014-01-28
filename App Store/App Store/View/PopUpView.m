//
//  PopUpView.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 28/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "PopUpView.h"

@implementation PopUpView

+(id)popUpView
{
    PopUpView *popUpView;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        popUpView = [[[NSBundle mainBundle] loadNibNamed:@"PopUpView_iPhone" owner:nil options:nil] objectAtIndex:0];

    }
    else
       popUpView = [[[NSBundle mainBundle] loadNibNamed:@"PopUpView_iPad" owner:nil options:nil] objectAtIndex:0];
    if ([popUpView isKindOfClass:[PopUpView class]])
    {
        return popUpView;
    }
    return nil;
}

-(void)animatePopUp
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
    [self.delegate popUpViewDidAppear];
}

- (IBAction)priceButtonClicked:(id)sender
{
    [self.priceButton setTitle:@"INSTALL" forState:UIControlStateNormal];
}

- (IBAction)closePopUp:(id)sender
{
    [self.delegate dismissPopUp];
}

- (IBAction)addToWishList:(id)sender
{
}

@end
