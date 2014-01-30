//
//  AsynchronousImageLoader.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 30/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ImageLoader.h"
#import "AppCell.h"

@implementation ImageLoader

-(void)loadImageAsynchronouslyForURL:(NSString *)imageUrlString forCell:(AppCell *)cell
{
    self.appCell = cell;
    NSURL *imageURL = [NSURL URLWithString:imageUrlString];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:imageURL];
    
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:myRequest delegate:self];
    
    if (myConnection ==nil) {
        NSLog(@"Connection failed");
    }
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.delegate updateImageForCell:self.appCell withData:data];
}

@end
