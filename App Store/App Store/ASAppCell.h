//
//  AppCell.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASAppData;

@interface ASAppCell : UICollectionViewCell

- (void)configureCellWith:(ASAppData *)appData;

@end
