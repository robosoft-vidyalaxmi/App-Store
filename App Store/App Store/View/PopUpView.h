//
//  PopUpView.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 28/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopUpView;

@protocol PopUpViewDelegate <NSObject>

-(void)popUpViewDidAppear;
-(void)dismissPopUp;
-(void)addAppToWishList;

@end

@interface PopUpView : UIView

@property (nonatomic, assign) id<PopUpViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *appImageView;
@property (weak, nonatomic) IBOutlet UITextView *appNameTextView;
@property (weak, nonatomic) IBOutlet UITextView *inforationTextView;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;

- (IBAction)priceButtonClicked:(id)sender;
- (IBAction)closePopUp:(id)sender;
- (IBAction)addToWishListButtonClicked:(id)sender;

+(instancetype)popUpView;
-(void)animatePopUp;

@end
