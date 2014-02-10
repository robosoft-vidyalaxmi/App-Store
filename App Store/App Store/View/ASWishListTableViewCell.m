//
//  WishListTableViewCell.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 29/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASWishListTableViewCell.h"
#import "ASAppData.h"
#import "AsyncImageView.h"

@interface ASWishListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *appImageView;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;

- (IBAction)priceButtonClicked:(id)sender;

@end

@implementation ASWishListTableViewCell

- (IBAction)priceButtonClicked:(id)sender
{
    [self.priceButton setTitle:ASInstallTitle forState:UIControlStateNormal];
}

- (void)configureCellWith:(ASAppData *)appData
{
    self.appImageView.imageURL = appData.imageUrl;
    self.appNameLabel.text = [appData appName];
    self.categoryLabel.text = [appData category];
    [self.priceButton setTitle:appData.price forState:UIControlStateNormal];
    
    //add border to button
    [[self.priceButton layer] setBorderWidth:2.0f];
    [[self.priceButton layer] setBorderColor:[UIColor blueColor].CGColor];
}

@end
