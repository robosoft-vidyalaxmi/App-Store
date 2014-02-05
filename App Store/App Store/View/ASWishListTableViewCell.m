//
//  WishListTableViewCell.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 29/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASWishListTableViewCell.h"

@implementation ASWishListTableViewCell

- (IBAction)priceButtonClicked:(id)sender
{
    [self.priceButton setTitle:kInstallTitle forState:UIControlStateNormal];
}
@end
