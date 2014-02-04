//
//  JSONParser.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASJSONParser.h"
#import "ASAppData.h"

@implementation ASJSONParser

//parses JSON data from iTunes asynchronously using NSURLConnection
-(void)parseAppDataUsingFeed:(NSString *)jsonFeed
{
    NSURL *jsonFeedURL = [NSURL URLWithString:jsonFeed];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:jsonFeedURL];
    
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    if (urlConnection == nil)
    {
        NSLog(@"Connection failed");
    }
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions error:&error];
    
    NSArray *feedArray = [NSArray arrayWithArray:[jsonDictionary valueForKeyPath:@"feed.entry"]];
    self.appDataArray = [[NSMutableArray alloc] initWithCapacity:kTopAppLimit];
    
    for (NSDictionary *appEntry in feedArray)
    {
        //convert dictionary to appData object
        ASAppData *appData = [[ASAppData alloc] initAppDataFromDictionary:appEntry];
        [self.appDataArray addObject:appData];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate loadParsedData:self.appDataArray];
}

@end
