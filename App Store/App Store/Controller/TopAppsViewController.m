//
//  TopFreeAppsViewController.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "TopAppsViewController.h"
#import "JSONParser.h"
#import "AppCell.h"
#import "AppData.h"
#import "SearchHeaderView.h"
#import "PopUpViewController.h"

@interface TopAppsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchDisplayDelegate>

@property (nonatomic, strong) NSArray *appDataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) JSONParser *jsonParser;
@property (nonatomic) BOOL searchBarShouldDisplay;


-(IBAction)searchForApps:(id)sender;

@end

@implementation TopAppsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self setModalPresentationStyle:UIModalPresentationCurrentContext];
	self.jsonParser = [[JSONParser alloc] init];
    self.appDataArray = [[NSArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([self.navigationItem.title isEqualToString:@"Top Free Apps"])
    {
        self.appDataArray = [self.jsonParser parseAppDataUsingFeed:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=25/json"];
    }
    else if([self.navigationItem.title isEqualToString:@"Top Paid Apps"])
    {
        self.appDataArray = [self.jsonParser parseAppDataUsingFeed:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=25/json"];
    }
}

#pragma mark UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.appDataArray count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor blueColor];
    [self updateDataForCell:cell atIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:
(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SearchHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    return headerView;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"popUp" sender:self];
    
}

#pragma mark UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGSize retval = CGSizeMake(kItemWidth_iPhone, kItemHeight_iPhone);
        return retval;
    }
    else
    {
        CGSize retval = CGSizeMake(kItemWidth_iPad, kItemHeight_iPad);
        return retval;
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        //todo
    }
    return UIEdgeInsetsMake(kEdgeInsetsTop, kEdgeInsetsLeft, kEdgeInsetsBottom, kEdgeInsetsRight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.searchBarShouldDisplay == NO) {
        return CGSizeMake(0, 0);
    }else {
        return CGSizeMake(self.collectionView.bounds.size.width, 50);
    }
}

#pragma mark Updating UICollectionViewCell

-(void)updateDataForCell:(AppCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    AppData *appData = [[AppData alloc] init];
    appData = [self.appDataArray objectAtIndex:indexPath.row];
    
    cell.appImage.image = nil;
    
    //perform background operation as it takes long time to load images
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backgroundQueue, ^{
        [cell.activityIndicator startAnimating];
        NSURL *url = [NSURL URLWithString:[[appData.imagePathList objectAtIndex:0] valueForKey:@"label"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.activityIndicator stopAnimating];
            cell.appImage.image = image;
        });
    });
    cell.nameTextView.text = appData.appName;
    cell.categoryLabel.text = appData.category;
    cell.priceLabel.text = appData.price;
}

#pragma mark Search Button

-(IBAction)searchForApps:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.searchBarShouldDisplay = YES;
        [self.collectionView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"popUp"])
	{
        UIViewController *controller=segue.destinationViewController;
        if([controller isKindOfClass:[PopUpViewController class]])
        {
            PopUpViewController *popUpViewController = (PopUpViewController *)controller;
            popUpViewController.indexPathForSelectedItem = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
            [popUpViewController setLabels:self.appDataArray];
        }
	}
}

@end
