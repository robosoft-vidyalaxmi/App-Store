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
#import "StandardPaths.h"

@interface ASWishListTableViewController () 

@property (nonatomic, strong) NSMutableArray *appDataArray;
@property (nonatomic, strong) NSMutableArray *wishListArray;
@property (nonatomic) BOOL isTableViewInEditingMode;

- (IBAction)editWishList:(id)sender;

@end

@implementation ASWishListTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //initialize wishlist array with contents of plist
    self.wishListArray = [NSArray arrayWithContentsOfFile:[[NSFileManager defaultManager] pathForPublicFile:ASWishListFile]];
    self.appDataArray = [[NSMutableArray alloc] init];
    
    for( NSDictionary *appDictionary in self.wishListArray)
    {
        ASAppData *appData = [[ASAppData alloc] initFromDictionary:appDictionary];
        [self.appDataArray addObject:appData];
    }
    
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
    ASWishListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ASTableCellIdentifier forIndexPath:indexPath];
    
    [cell configureCellWith:[self.appDataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //delete app from wishlist and update plist in app directory
    [self.wishListArray removeObjectAtIndex:indexPath.row];
    [self.appDataArray removeObjectAtIndex:indexPath.row];
    [self.wishListArray writeToFile:[[NSFileManager defaultManager] pathForPublicFile:ASWishListFile]  atomically:YES];
    
    [self.tableView reloadData];
}

- (IBAction)editWishList:(id)sender
{
    if (self.isTableViewInEditingMode == NO)
    {
        self.isTableViewInEditingMode = YES;
        
        //allow table view editing
        [self setEditing:YES];
        self.navigationItem.leftBarButtonItem.title = @"Done";
    }
    else
    {
        self.isTableViewInEditingMode = NO;
        
        //disable table view editing
        [self setEditing:NO];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
    }
}

@end
