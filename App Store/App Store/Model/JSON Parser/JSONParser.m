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
-(void)parseAppDataUsingFeed:(NSURL *)jsonFeedURL
{
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonFeedURL];
    NSError *error;
    self.jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                            options:kNilOptions error:&error];
    if (!error) {
        NSArray *feedArray = [NSArray arrayWithArray:[[self.jsonDictionary valueForKey:@"feed"] valueForKey:@"entry"]];
        //NSLog(@"Parsed JSON data= %@", feedArray);
        
        for (NSDictionary *appEntry in feedArray) {
            AppData *appData=[[AppData alloc] initAppDataFromDictionary:appEntry];
            NSLog(@"App name=%@", appData.price);
        }
    }
    
}

@end
