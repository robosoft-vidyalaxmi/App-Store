//
//  PopUpViewCOntrollerViewController.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 26/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopUpViewController;
@class AppData;

@protocol PopUpViewControllerDelegate <NSObject>

-(void)newItemAddedToWishListWithAppData:(AppData *)appData;

@end
@interface PopUpViewController : UIViewController

@property (nonatomic, strong) NSIndexPath *indexPathForSelectedItem;
@property (nonatomic, assign) id<PopUpViewControllerDelegate> delegate;

-(void)setViewProperties:(NSArray *)appDataArray;

@end
