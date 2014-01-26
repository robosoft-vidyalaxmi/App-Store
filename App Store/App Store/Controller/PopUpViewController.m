//
//  PopUpViewCOntrollerViewController.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 26/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "PopUpViewController.h"
#import "AppData.h"

@interface PopUpViewController ()

@property (nonatomic, strong) AppData *appData;
@property (weak, nonatomic) IBOutlet UITextView *authorTextView;
@property (weak, nonatomic) IBOutlet UITextView *copyrightTextView;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UITextView *releaseDateTextView;

- (IBAction)closeButton:(id)sender;
- (IBAction)addToWishListButton:(id)sender;

@end

@implementation PopUpViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.appData = [[AppData alloc] init];
}

-(void)setViewProperties:(NSArray *)appDataArray
{
    self.appData = [appDataArray objectAtIndex:self.indexPathForSelectedItem.row];
    
    UITextView *authorTextView = (UITextView *)[self.view viewWithTag:51];
    authorTextView.text = [NSString stringWithFormat:@"Author: %@", self.appData.authorName];
    self.copyrightTextView.text = [NSString stringWithFormat:@"Copyright: %@", self.appData.copyright];
    self.summaryTextView.text = [NSString stringWithFormat:@"Summary: %@", self.appData.summary];
    self.releaseDateTextView.text = [NSString stringWithFormat:@"Release Date: %@", self.appData.releaseDate];
}

- (IBAction)closeButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addToWishListButton:(id)sender
{
    [self.delegate newItemAddedToWishListWithAppData:self.appData];
}
@end
