//
//  PopUpView.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 28/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASPopUpView;
@class ASAppData;

@protocol ASPopUpViewDelegate <NSObject>

- (void)popUpViewDidAppear:(ASPopUpView *)popUpView;
- (void)dismissPopUp;
- (void)addAppToWishList;

@end

@interface ASPopUpView : UIView

@property (nonatomic, assign) id<ASPopUpViewDelegate> delegate;

+ (instancetype)popUpView;
- (void)animatePopUp;
- (void)configurePopUpForAppData:(ASAppData *)appData;

@end
