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

@property (nonatomic, strong) NSArray *wishListArray;

@end

@implementation WishListTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSString *datapath = [[ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"Wishlist.plist"];
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

-(void)updateDataForCell:(WishListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *appDictionary = [[NSDictionary alloc] initWithDictionary:[self.wishListArray objectAtIndex:indexPath.row]];
    AppData *appData = [[AppData alloc] initAppDataFromDictionary:appDictionary];
    NSURL *url = [NSURL URLWithString:appData.imageUrlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    cell.imageView.image = image;
    cell.appNameLabel.text = [appData appName];
    cell.categoryLabel.text = [appData category];
    [cell.priceButton setTitle:appData.price forState:UIControlStateNormal];
}

@end
