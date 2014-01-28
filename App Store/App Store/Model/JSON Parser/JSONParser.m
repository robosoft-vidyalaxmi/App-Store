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

//parses JSON data from iTunes using JSON feed URL
-(NSArray *)parseAppDataUsingFeed:(NSString *)jsonFeed
{
    NSURL *jsonFeedURL = [NSURL URLWithString:jsonFeed];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonFeedURL];
    NSError *error;
    self.jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:kNilOptions error:&error];
    
    
    NSArray *feedArray = [NSArray arrayWithArray:[[self.jsonDictionary valueForKey:@"feed"] valueForKey:@"entry"]];
    self.appDataArray = [[NSMutableArray alloc] initWithCapacity:25];
    
    for (NSDictionary *appEntry in feedArray)
    {
        AppData *appData = [[AppData alloc] initAppDataFromDictionary:appEntry];
        [self.appDataArray addObject:appData];
    }
    return self.appDataArray;
}

@end
