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
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imageURL];
    
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    if (urlConnection == nil)
    {
        NSLog(@"Connection failed");
    }
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.delegate updateImageForCell:self.appCell withData:data];
}

@end
 