//
//  JSONParser.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "JSONParser.h"
#import "AppData.h"

@implementation JSONParser

//parses JSON data from iTunes asynchronously using NSURLConnection
-(void)parseAppDataUsingFeed:(NSString *)jsonFeed
{
    NSURL *jsonFeedURL = [NSURL URLWithString:jsonFeed];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:jsonFeedURL];
    
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:myRequest delegate:self];
    
    if (myConnection ==nil) {
        NSLog(@"Connection failed");
    }
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions error:&error];
    
    NSArray *feedArray = [NSArray arrayWithArray:[[jsonDictionary valueForKey:@"feed"] valueForKey:@"entry"]];
    self.appDataArray = [[NSMutableArray alloc] initWithCapacity:kTopAppLimit];
    
    for (NSDictionary *appEntry in feedArray)
    {
        AppData *appData = [[AppData alloc] initAppDataFromDictionary:appEntry];
        [self.appDataArray addObject:appData];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate loadParsedData:self.appDataArray];
}

@end
