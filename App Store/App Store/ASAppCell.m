//
//  AppCell.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASAppCell.h"
#import "ASAppData.h"
#import "AsyncImageView.h"

@interface ASAppCell ()

@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *appImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ASAppCell

- (void)configureCellWith:(ASAppData *)appData
{
    self.appImageView.imageURL = appData.imageUrl;
    self.appNameLabel.text = appData.appName;
    self.categoryLabel.text = appData.category;
    self.priceLabel.text = appData.price;
}

@end
