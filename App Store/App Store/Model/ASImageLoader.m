//
//  AsynchronousImageLoader.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 30/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASImageLoader.h"

@implementation ASImageLoader

-(void)loadImageAsynchronouslyForURL:(NSString *)imageUrlString forCell:(id)cell
{
    self.cell = cell;
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
    [self.delegate updateImageForCell:self.cell withData:data];
}

@end
 