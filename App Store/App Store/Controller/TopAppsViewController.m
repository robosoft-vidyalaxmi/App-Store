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

@interface TopAppsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *appDataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) JSONParser *jsonParser;

@end

@implementation TopAppsViewController

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
	self.jsonParser = [[JSONParser alloc] init];
    self.appDataArray = [[NSArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([self.navigationItem.title isEqualToString:@"Top Free Apps"])
    {
        self.appDataArray = [self.jsonParser parseAppDataUsingFeed:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=25/json"];
    }
    else if([self.navigationItem.title isEqualToString:@"Top Paid Apps"])
    {
        self.appDataArray = [self.jsonParser parseAppDataUsingFeed:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=25/json"];
    }
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
    [self updateDataForCell:cell atIndexPath:indexPath];
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval = CGSizeMake(135, 150);
    return retval;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 20, 30, 20);
}

#pragma mark Updating UICollectionViewCell
-(void)updateDataForCell:(AppCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    AppData *appData = [[AppData alloc] init];
    appData = [self.appDataArray objectAtIndex:indexPath.row];
    
    cell.imageView.image = nil;
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backgroundQueue, ^{
        [cell.activityIndicator startAnimating];
        NSURL *url = [NSURL URLWithString:[[appData.imagePathList objectAtIndex:0] valueForKey:@"label"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.activityIndicator stopAnimating];
            cell.imageView.image = image;
        });
    });
    cell.nameLabel.text = appData.appName;
    cell.categoryLabel.text = appData.category;
    cell.priceLabel.text = appData.price;
}



@end
