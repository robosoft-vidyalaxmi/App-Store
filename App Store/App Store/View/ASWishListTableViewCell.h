//
//  WishListTableViewCell.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 29/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASAppData;

@interface ASWishListTableViewCell : UITableViewCell

- (void)configureCellWith:(ASAppData *)appData;

@end
