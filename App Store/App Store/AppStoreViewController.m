//
//  AppStoreViewController.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "AppStoreViewController.h"
#import "JSONParser.h"

@interface AppStoreViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *price;


@end

@implementation AppStoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    JSONParser *jsonParser = [[JSONParser alloc] init];
    NSURL *url=[NSURL URLWithString:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=25/json"];
    [jsonParser parseAppDataUsingFeed:url];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
