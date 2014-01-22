//
//  AppCell.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
