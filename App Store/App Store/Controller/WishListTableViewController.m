//
//  WishListTableViewController.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 29/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "WishListTableViewController.h"
#import "WishListTableViewCell.h"
#import "AppData.h"

@interface WishListTableViewController ()

@property (nonatomic, strong) NSMutableArray *wishListArray;
@property (nonatomic) BOOL isTableViewInEditingMode;

- (IBAction)editWishList:(id)sender;

@end

@implementation WishListTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //initialize wishlist array with contents of plist
    NSString *datapath = [[ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:kplistFileName];
    self.wishListArray = [NSArray arrayWithContentsOfFile:datapath];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

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
    static NSString *CellIdentifier = @"wishListCell";
    WishListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self updateDataForCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *datapath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:kplistFileName];
    
    //delete app from wishlist and update plist in app directory
    [self.wishListArray removeObjectAtIndex:indexPath.row];
    [self.wishListArray writeToFile:datapath atomically:YES];
    
    [self.tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)updateDataForCell:(WishListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *appDictionary = [[NSDictionary alloc] initWithDictionary:[self.wishListArray objectAtIndex:indexPath.row]];
    AppData *appData = [[AppData alloc] initAppDataFromDictionary:appDictionary];
    
    NSURL *url = [NSURL URLWithString:appData.imageUrlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.imageView.image = [[UIImage alloc] initWithData:data];
    
    cell.appNameLabel.text = [appData appName];
    cell.categoryLabel.text = [appData category];
    [cell.priceButton setTitle:appData.price forState:UIControlStateNormal];
    
    //add border to button
    [[cell.priceButton layer] setBorderWidth:2.0f];
    [[cell.priceButton layer] setBorderColor:[UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0].CGColor];
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
@end
