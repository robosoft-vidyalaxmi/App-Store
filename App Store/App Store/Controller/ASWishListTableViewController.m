//
//  WishListTableViewController.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 29/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASWishListTableViewController.h"
#import "ASWishListTableViewCell.h"
#import "ASAppData.h"
#import "ASImageLoader.h"

@interface ASWishListTableViewController () <ASImageLoaderDelegate>

@property (nonatomic, strong) NSMutableArray *wishListArray;
@property (nonatomic) BOOL isTableViewInEditingMode;

- (IBAction)editWishList:(id)sender;

@end

@implementation ASWishListTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //initialize wishlist array with contents of plist
    NSString *datapath = [[ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:kplistFileName];
    self.wishListArray = [NSArray arrayWithContentsOfFile:datapath];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.wishListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASWishListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCellIdentifier forIndexPath:indexPath];
    [self updateDataForCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *datapath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:kplistFileName];
    
    //delete app from wishlist and update plist in app directory
    [self.wishListArray removeObjectAtIndex:indexPath.row];
    [self.wishListArray writeToFile:datapath atomically:YES];
    
    [self.tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - ImageLoader delegate methods

-(void)updateImageForCell:(id)cell withData:(NSData *)data
{
    UIImage *image = [[UIImage alloc] initWithData:data];
    if ([cell isKindOfClass:[ASWishListTableViewCell class]])
    {
        ASWishListTableViewCell *wishListTableViewCell = (ASWishListTableViewCell *)cell;
        //set image for table view cells
        wishListTableViewCell.appImageView.image = image;
    }
}

- (IBAction)editWishList:(id)sender
{
    if (self.isTableViewInEditingMode == NO)
    {
        self.isTableViewInEditingMode = YES;
        
        //allow table view editing
        [self setEditing:YES];
        self.navigationItem.leftBarButtonItem.title = kButtonTitleDone;
    }
    else
    {
        self.isTableViewInEditingMode = NO;
        
        //disable table view editing
        [self setEditing:NO];
        self.navigationItem.leftBarButtonItem.title = kButtonTitleEdit;
    }
}

#pragma mark - User defined methods

-(void)updateDataForCell:(ASWishListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *appDictionary = [[NSDictionary alloc] initWithDictionary:[self.wishListArray objectAtIndex:indexPath.row]];
    ASAppData *appData = [[ASAppData alloc] initAppDataFromDictionary:appDictionary];
    
    //load images asynchronously using NSURLConnection
    ASImageLoader *imageLoader = [[ASImageLoader alloc] init];
    imageLoader.delegate = self;
    [imageLoader loadImageAsynchronouslyForURL:appData.imageUrlString forCell:cell];
    
    cell.appNameLabel.text = [appData appName];
    cell.categoryLabel.text = [appData category];
    [cell.priceButton setTitle:appData.price forState:UIControlStateNormal];
    
    //add border to button
    [[cell.priceButton layer] setBorderWidth:2.0f];
    [[cell.priceButton layer] setBorderColor:[UIColor blueColor].CGColor];
}

@end
