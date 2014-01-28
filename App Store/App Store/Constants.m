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
CGFloat const kItemHeight_iPhone = 100;
CGFloat const kItemWidth_iPad = 150;
CGFloat const kItemHeight_iPad = 150;
CGFloat const kHeaderViewHeight = 50;
CGFloat const kEdgeInsetsTop = 10;
CGFloat const kEdgeInsetsLeft = 10;
CGFloat const kEdgeInsetsBottom = 10;
CGFloat const kEdgeInsetsRight = 10;
CGFloat const kCollectionViewHeaderHeight = 50;
NSString *const kTopFreeApps = @"Top Free Apps";
NSString *const kTopPaidApps = @"Top Paid Apps";
NSString *const kWishList = @"Wish List";
NSString *const kWishListArray = @"Wish List Array";
NSString *const kTopFreeAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=25/json";
NSString *const kTopPaidAppsJsonFeed = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=25/json";
NSString *const kAlertMessage = @"App not found";

@end
