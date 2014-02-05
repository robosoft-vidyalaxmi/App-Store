//
//  Constants.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 26/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASConstants.h"

@implementation ASConstants

CGFloat const TAItemWidth_iPhone = 90;
CGFloat const TAItemHeight_iPhone = 90;
CGFloat const TAItemWidth_iPad = 150;
CGFloat const TAItemHeight_iPad = 150;
CGFloat const TAHeaderViewHeight = 50;
CGFloat const TAEdgeInsetsTop = 10;
CGFloat const TAEdgeInsetsLeft = 10;
CGFloat const TAEdgeInsetsBottom = 10;
CGFloat const TAEdgeInsetsRight = 10;
CGFloat const TACollectionViewHeaderHeight = 50;
CGFloat const TACollectionViewOffsetHeight = -64;
int const TATopAppLimit = 50;
NSString *const TATopFreeAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=50/json";
NSString *const TATopPaidAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=50/json";
NSString *const TAInstallTitle = @"INSTALL";
NSString *const TAplistFileName = @"WishList.plist";
NSString *const TAWishListFile = @"WishList";
NSString *const TAWishListFileExtension = @"plist";
NSString *const TATableCellIdentifier = @"wishListCell";
NSString *const TACollectionViewIdentifier = @"cell";
NSString *const TAHeaderViewIdentifier = @"headerView";

@end
