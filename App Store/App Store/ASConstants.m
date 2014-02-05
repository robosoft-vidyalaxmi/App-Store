//
//  Constants.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 26/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASConstants.h"

@implementation ASConstants

CGFloat const ASItemWidth_iPhone = 90;
CGFloat const ASItemHeight_iPhone = 90;
CGFloat const ASItemWidth_iPad = 150;
CGFloat const ASItemHeight_iPad = 150;
CGFloat const ASHeaderViewHeight = 50;
CGFloat const ASEdgeInsetsTop = 10;
CGFloat const ASEdgeInsetsLeft = 10;
CGFloat const ASEdgeInsetsBottom = 10;
CGFloat const ASEdgeInsetsRight = 10;
CGFloat const ASCollectionViewHeaderHeight = 50;
CGFloat const ASCollectionViewOffsetHeight = -64;
int const ASTopAppLimit = 50;
NSString *const ASTopFreeAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=50/json";
NSString *const ASTopPaidAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=50/json";
NSString *const ASInstallTitle = @"INSTALL";
NSString *const ASPlistFileName = @"WishList.plist";
NSString *const ASWishListFile = @"WishList";
NSString *const ASWishListFileExtension = @"plist";
NSString *const ASTableCellIdentifier = @"wishListCell";
NSString *const ASCollectionViewIdentifier = @"cell";
NSString *const ASHeaderViewIdentifier = @"headerView";

@end
