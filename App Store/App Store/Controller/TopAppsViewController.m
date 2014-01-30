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
#import "PopUpView.h"
#import "ImageLoader.h"

@interface TopAppsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchDisplayDelegate, UIAlertViewDelegate, SearchDelegate, PopUpViewDelegate, JSONParserDelegate, ImageLoaderDelegate>

@property (nonatomic, strong) NSArray *appDataArray;
@property (nonatomic, strong) NSMutableArray *filteredAppDataArray;
@property (nonatomic, strong) NSMutableArray *wishListArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) JSONParser *jsonParser;
@property (nonatomic) BOOL isSearchBarDisplayed;
@property (nonatomic) BOOL isFiltered;
@property (nonatomic) BOOL isItemSelected;
@property (nonatomic, strong) PopUpView *popUpView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

-(IBAction)searchForApps:(id)sender;

@end

@implementation TopAppsViewController

-(void)setUpModel
{
    self.jsonParser = [[JSONParser alloc] init];
    self.jsonParser.delegate = self;
    self.appDataArray = [[NSArray alloc] init];
}

-(void)setUpPopUpView
{
    self.popUpView = [PopUpView popUpView];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if ([self.tabBarController.tabBar.items indexOfObject:self.tabBarController.tabBar.selectedItem] == 0)
    {
         [self.jsonParser parseAppDataUsingFeed:kTopFreeAppsJsonFeed];
    }
    else if([self.tabBarController.tabBar.items indexOfObject:self.tabBarController.tabBar.selectedItem] == 1)
    {
         [self.jsonParser parseAppDataUsingFeed:kTopPaidAppsJsonFeed];
    }
    [self setUpPopUpView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self dismissPopUp];
}

#pragma mark UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isFiltered)
    {
        return [self.filteredAppDataArray count];
    }
    else return [self.appDataArray count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewIdentifier forIndexPath:indexPath];

    [self updateDataForCell:cell atIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:
(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SearchHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewIdentifier forIndexPath:indexPath];
    headerView.delegate = self;
    return headerView;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.isItemSelected = YES;
    [self setUpPopUpViewCenter];
    [self.popUpView animatePopUp];
    [self configurePopUpForCellAtIndexPath:(NSIndexPath *)indexPath];
    
}

#pragma mark UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
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
    return UIEdgeInsetsMake(kEdgeInsetsTop, kEdgeInsetsLeft, kEdgeInsetsBottom, kEdgeInsetsRight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.isSearchBarDisplayed == NO)
    {
        return CGSizeMake(0, 0);
    }
    else
    {
        return CGSizeMake(self.collectionView.bounds.size.width, kCollectionViewHeaderHeight);
    }
}

#pragma mark Updating UICollectionViewCell

-(void)updateDataForCell:(AppCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    AppData *appData = [[AppData alloc] init];
    if (self.isFiltered)
    {
        appData = [self.filteredAppDataArray objectAtIndex:indexPath.row];
    }
    else
        appData = [self.appDataArray objectAtIndex:indexPath.row];
    
    cell.appImageView.image = nil;
    [cell.activityIndicator startAnimating];
    //load images using NSURLConnection
    ImageLoader *imageLoader = [[ImageLoader alloc] init];
    imageLoader.delegate = self;
    [imageLoader loadImageAsynchronouslyForURL:appData.imageUrlString forCell:cell];

    cell.appNameLabel.text = appData.appName;
    cell.categoryLabel.text = appData.category;
    cell.priceLabel.text = appData.price;
}

#pragma mark - ImageLoader delegate method

-(void)updateImageForCell:(AppCell *)cell withData:(NSData *)data
{
    UIImage *image = [[UIImage alloc] initWithData:data];
    cell.appImageView.image = image;
    [cell.activityIndicator stopAnimating];
}

#pragma mark - JSONParser delegate method
-(void)loadParsedData:(NSArray *)array
{
    self.appDataArray = array;
    [self.collectionView reloadData];
}

#pragma mark Search Button

-(IBAction)searchForApps:(id)sender
{
    self.isSearchBarDisplayed = YES;
    [self.collectionView reloadData];
    
}

#pragma mark SearchDelegate

-(void)filterContentForSearchText:(NSString *)searchText inSearchBar:(UISearchBar *)searchBar
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
        self.filteredAppDataArray = [[NSMutableArray alloc] init];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.appName contains[c] %@",searchText];
        NSMutableArray *appNameArray = [[NSMutableArray alloc] init];
        for (AppData *appData in self.appDataArray)
        {
            [appNameArray addObject:appData];
        }
        NSArray *tempArray = [appNameArray filteredArrayUsingPredicate:predicate];
        self.filteredAppDataArray = [NSMutableArray arrayWithArray:tempArray];
    }
    [self.collectionView reloadData];
    [searchBar becomeFirstResponder];
}

-(void)displayAlert
{
    //if appName not found
    if ([self.filteredAppDataArray count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:kAlertMessage delegate:self cancelButtonTitle:kAlertCancelButtonTitle otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)hideSearchBar
{
    self.isSearchBarDisplayed = NO;
    self.isFiltered = NO;
    [self.collectionView reloadData];
}

-(void)setUpPopUpViewCenter
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

#pragma mark PopUpViewDelegate

-(void)popUpViewDidAppear
{
    //add tap gesture recognizer so tat pop up can disappear when tapped outside the view
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    //disable scrolling when popUp is shown
    self.collectionView.scrollEnabled = NO;
}

-(void)dismissPopUp
{
    self.popUpView.alpha = 0;
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    
    //enable scrolling when popUp is hidden
    self.collectionView.scrollEnabled = YES;
    self.isItemSelected = NO;
}

-(void)addAppToWishList
{
    //Get plist file path where setails about apps added to wishlist are stored
    NSString *datapath = [[ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:kplistFileName];
    
    NSError *error;
    
    //if file doesn't exist then create file
    if (![[NSFileManager defaultManager] fileExistsAtPath: datapath])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:kWishListFile ofType:kWishListFileExtension];
        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:datapath error:&error];
    }
    
    //set plist data into mutable array
    self.wishListArray = [[NSArray arrayWithContentsOfFile:datapath] mutableCopy];
    
    //if plist file is empty
    if (self.wishListArray.count == 0)
    {
        self.wishListArray = [[NSMutableArray alloc] init];
    }
    NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
    AppData *appData = [self.appDataArray objectAtIndex:indexPath.row];
    if(![self.wishListArray containsObject:appData.appDetailsDictionary])
    {
        [self.wishListArray addObject:appData.appDetailsDictionary];
        
        //write data from mutable array to plist file
        [self.wishListArray writeToFile:datapath atomically:YES];
    }
}

-(void)configurePopUpForCellAtIndexPath:(NSIndexPath *)indexPath
{
    AppData *appData = [[AppData alloc] init];
    appData = [self.appDataArray objectAtIndex:indexPath.row];
    
    //perform background operation to load image
    self.popUpView.appImageView.image = nil;
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backgroundQueue, ^{
        NSURL *url = [NSURL URLWithString:appData.imageUrlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.popUpView.appImageView.image = image;
        });
    });
    
    self.popUpView.appNameTextView.text = appData.appName;
    [self.popUpView.priceButton setTitle:appData.price forState:UIControlStateNormal];
    self.popUpView.summaryTextView.text = [NSString stringWithFormat:@"Description:\n%@",appData.summary];
    self.popUpView.inforationTextView.text = [NSString stringWithFormat:@"Information\nAuthor: %@\nCategory: %@\nCopyright: %@\nRelease Date: %@",appData.authorName, appData.category, appData.copyright, appData.releaseDate];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(self.isItemSelected)
        [self setUpPopUpViewCenter];
}

@end
