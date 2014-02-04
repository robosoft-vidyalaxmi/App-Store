//
//  Constants.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 26/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASConstants.h"

@implementation ASConstants

CGFloat const kItemWidth_iPhone = 90;
CGFloat const kItemHeight_iPhone = 90;
CGFloat const kItemWidth_iPad = 150;
CGFloat const kItemHeight_iPad = 150;
CGFloat const kHeaderViewHeight = 50;
CGFloat const kEdgeInsetsTop = 10;
CGFloat const kEdgeInsetsLeft = 10;
CGFloat const kEdgeInsetsBottom = 10;
CGFloat const kEdgeInsetsRight = 10;
CGFloat const kCollectionViewHeaderHeight = 50;
CGFloat const kCollectionViewOffsetHeight = -64;
int const kTopAppLimit = 50;
NSString *const kTopFreeAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=50/json";
NSString *const kTopPaidAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=50/json";
NSString *const kInstallTitle = @"INSTALL";
NSString *const kButtonTitleDone = @"Done";
NSString *const kButtonTitleEdit = @"Edit";
NSString *const kplistFileName = @"WishList.plist";
NSString *const kWishListFile = @"WishList";
NSString *const kWishListFileExtension = @"plist";
NSString *const kTableCellIdentifier = @"wishListCell";
NSString *const kCollectionViewIdentifier = @"cell";
NSString *const kHeaderViewIdentifier = @"headerView";
NSString *const kPopUpView_iPhone = @"ASPopUpView_iPhone";
NSString *const kPopUpView_iPad = @"ASPopUpView_iPad";

@end
