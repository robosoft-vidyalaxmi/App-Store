//
//  PopUpViewCOntrollerViewController.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 26/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpViewController : UIViewController

@property (nonatomic, strong) NSIndexPath *indexPathForSelectedItem;

-(void)setLabels:(NSArray *)appDataArray;

@end
