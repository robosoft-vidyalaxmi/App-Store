//
//  TopFreeAppsViewController.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "TopFreeAppsViewController.h"
#import "JSONParser.h"
#import "AppCell.h"

@interface TopFreeAppsViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation TopFreeAppsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	JSONParser *jsonParser = [[JSONParser alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=25/json"];
    [jsonParser parseAppDataUsingFeed:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 25;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.nameLabel.text = @"AppName";
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval = CGSizeMake(100, 100);
    retval.height += 35;
    retval.width += 35;
    return retval;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

@end
