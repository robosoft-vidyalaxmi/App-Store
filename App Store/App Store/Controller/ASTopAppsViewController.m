//
//  TopFreeAppsViewController.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASTopAppsViewController.h"
#import "ASAppCell.h"
#import "ASAppData.h"
#import "ASSearchHeaderView.h"
#import "ASPopUpView.h"
#import "StandardPaths.h"
#import "RequestQueue.h"

@interface ASTopAppsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, ASSearchDelegate, ASPopUpViewDelegate>

@property (nonatomic, strong) NSMutableArray *appDataArray;
@property (nonatomic, strong) NSMutableArray *filteredAppDataArray;
@property (nonatomic, strong) NSMutableArray *wishListArray;
@property (nonatomic) BOOL isSearchBarDisplayed;
@property (nonatomic) BOOL isFiltered;
@property (nonatomic) BOOL isPopUpDisplayed;
@property (nonatomic, strong) ASPopUpView *popUpView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UISearchBar *appSearchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)searchForApps:(id)sender;

@end

@implementation ASTopAppsViewController

- (void)setUpModel
{
    self.appDataArray = [[NSMutableArray alloc] init];
}

- (void)setUpPopUpView
{
    self.popUpView = [ASPopUpView popUpView];
    self.popUpView.delegate= self;
    [self.collectionView addSubview:self.popUpView];
    self.popUpView.alpha = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpModel];
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(dismissPopUp)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSURLRequest *request;
    
    //check which tab bar item is selected
    if ([self.tabBarController.tabBar.items indexOfObject:self.tabBarController.tabBar.selectedItem] == 0)
    {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:ASTopFreeAppsJsonFeed]];
    }
    else if([self.tabBarController.tabBar.items indexOfObject:self.tabBarController.tabBar.selectedItem] == 1)
    {
         request = [NSURLRequest requestWithURL:[NSURL URLWithString:ASTopPaidAppsJsonFeed]];
    }
    
    [self loadJSONFeedFor:request];
    [self setUpPopUpView];
}

- (void)loadJSONFeedFor:(NSURLRequest *)request
{
    [[RequestQueue mainQueue] addRequest:request completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alertView show];
         }
         else
         {
             NSError *error;
             NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:kNilOptions error:&error];
             
             NSArray *feedArray = [NSArray arrayWithArray:[jsonDictionary valueForKeyPath:@"feed.entry"]];
             self.appDataArray = [[NSMutableArray alloc] initWithCapacity:ASTopAppLimit];
             
             for (NSDictionary *appEntry in feedArray)
             {
                 //convert dictionary to appData object
                 ASAppData *appData = [[ASAppData alloc] initFromDictionary:appEntry];
                 [self.appDataArray addObject:appData];
             }
             [self.collectionView reloadData];
         }
     }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if(self.isPopUpDisplayed)
    {
        [self dismissPopUp];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(self.isPopUpDisplayed)
        [self setUpPopUpViewCenter];
}

#pragma mark UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isFiltered)
    {
        return [self.filteredAppDataArray count];
    }
    else return [self.appDataArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ASAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ASCollectionViewIdentifier forIndexPath:indexPath];
    
    ASAppData *appData;
    if (self.isFiltered)
    {
        appData = [self.filteredAppDataArray objectAtIndex:indexPath.row];
    }
    else
        appData = [self.appDataArray objectAtIndex:indexPath.row];

    [cell configureCellWith:appData];
    
    //make search bar first responder to keep keyboard up
    if (self.isFiltered && ![self.appSearchBar isFirstResponder])
    {
        [self.appSearchBar becomeFirstResponder];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ASSearchHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ASHeaderViewIdentifier forIndexPath:indexPath];
    headerView.delegate = self;
    return headerView;
}

#pragma mark UICollectionViewDelegate method

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setUpPopUpViewCenter];
    [self.popUpView configurePopUpForAppData:[self.appDataArray objectAtIndex:indexPath.row]];
    [self.popUpView animatePopUp];
    self.isPopUpDisplayed = YES;
}

#pragma mark UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize retval = CGSizeMake(ASItemWidth_iPhone, ASItemHeight_iPhone);
        return retval;
    }
    else
    {
        CGSize retval = CGSizeMake(ASItemWidth_iPad, ASItemHeight_iPad);
        return retval;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(ASEdgeInsetsTop, ASEdgeInsetsLeft, ASEdgeInsetsBottom, ASEdgeInsetsRight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.isSearchBarDisplayed == NO)
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(self.collectionView.bounds.size.width, ASCollectionViewHeaderHeight);

    }
}

#pragma mark - Search Button Action

- (IBAction)searchForApps:(id)sender
{
    self.isSearchBarDisplayed = YES;
    [self.collectionView reloadData];
    
    //reset scroll on collection view
    [self.collectionView setContentOffset:CGPointMake(0, ASCollectionViewOffsetHeight) animated:YES];
    
}

#pragma mark - SearchDelegate methods

- (void)filterContentForSearchText:(NSString *)searchText inSearchBar:(UISearchBar *)searchBar
{
    // Update the filtered array based on the search text
    if(searchText.length == 0)
    {
        self.isFiltered = NO;
        [self.filteredAppDataArray removeAllObjects];
        [self.filteredAppDataArray addObjectsFromArray:self.appDataArray];
    }
    else
    {
        self.isFiltered = YES;
        [self.filteredAppDataArray removeAllObjects];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.appName contains[c] %@",searchText];
        NSMutableArray *appNameArray = [[NSMutableArray alloc] init];
        for (ASAppData *appData in self.appDataArray)
        {
            [appNameArray addObject:appData];
        }
        NSArray *tempArray = [appNameArray filteredArrayUsingPredicate:predicate];
        self.filteredAppDataArray = [NSMutableArray arrayWithArray:tempArray];
    }
    
    self.appSearchBar = searchBar;
    [self.collectionView reloadData];
}

- (void)displayAlert
{
    //if appName not found
    if ([self.filteredAppDataArray count] == 0)
    {
        [self showAlertWithTitle:@"App not found"];
    }
}

- (void)hideSearchBar
{
    self.isSearchBarDisplayed = NO;
    self.isFiltered = NO;
    [self.collectionView reloadData];
}

#pragma mark PopUpViewDelegate methods

- (void)popUpViewDidAppear:(ASPopUpView *)popUpView
{
    //add tap gesture recognizer so tat pop up can disappear when tapped outside the view
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    //disable scrolling when popUp is shown
    self.collectionView.scrollEnabled = NO;
}

- (void)dismissPopUp
{
    self.popUpView.alpha = 0;
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    
    //enable scrolling when popUp is hidden
    self.collectionView.scrollEnabled = YES;
    self.isPopUpDisplayed = NO;
}

- (void)addAppToWishList
{
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:[[NSFileManager defaultManager] pathForPublicFile:ASWishListFile]];
    //if plist file is empty
    if (plistArray)
    {
        self.wishListArray = [plistArray mutableCopy];
    }
    else
    {
        //set plist data into mutable array
        self.wishListArray = [[NSMutableArray alloc] init];
    }
    
    //get the index path of item to be added to wish list
    NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
    ASAppData *appData = [self.appDataArray objectAtIndex:indexPath.row];
    
    //check that app is not already added to wish list
    if(![self.wishListArray containsObject:appData.appDetailsDictionary])
    {
        [self.wishListArray addObject:appData.appDetailsDictionary];
        
        //write data from mutable array to plist file
        [self.wishListArray writeToFile:[[NSFileManager defaultManager] pathForPublicFile:ASWishListFile] atomically:YES];
    }
    else
    {
        [self showAlertWithTitle:@"App already added to wish list"];
    }
}

- (void)showAlertWithTitle:(NSString *)alertTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:alertTitle delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)setUpPopUpViewCenter
{
    //Get the center of the screen coordinates
    CGPoint screenCenter = CGPointMake(([UIScreen mainScreen].bounds.size.width)/2, ([UIScreen mainScreen].bounds.size.height)/2);
    //convert it to window coordinates
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint pointInWindowCoords = [mainWindow convertPoint:screenCenter fromWindow:nil];
    //convert it to view coordinates
    CGPoint pointInCollectionViewCoords = [self.collectionView convertPoint:pointInWindowCoords fromView:mainWindow];
    self.popUpView.center = pointInCollectionViewCoords;
}

@end
