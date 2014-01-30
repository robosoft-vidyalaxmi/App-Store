//
//  Constants.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 26/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "Constants.h"

@implementation Constants

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
int const kTopAppLimit = 25;
NSString *const kTopFreeAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=25/json";
NSString *const kTopPaidAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=25/json";
NSString *const kAlertMessage = @"App not found";
NSString *const kAlertCancelButtonTitle = @"Cancel";
NSString *const kInstallTitle = @"INSTALL";
NSString *const kButtonTitleDone = @"Done";
NSString *const kButtonTitleEdit = @"Edit";
NSString *const kplistFileName = @"WishList.plist";
NSString *const kWishListFile = @"WishList";
NSString *const kWishListFileExtension = @"plist";
NSString *const kTableCellIdentifier = @"wishListCell";
NSString *const kCollectionViewIdentifier = @"cell";
NSString *const kHeaderViewIdentifier = @"headerView";
@end
