//
//  App_StoreTests.m
//  App StoreTests
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppData.h"

@interface App_StoreTests : XCTestCase
{
    NSURL *url;
    NSData *data;
    NSDictionary *jsonDictionary;
    NSArray *feedArray;
}
@end

@implementation App_StoreTests

- (void)setUp
{
    [super setUp];
    [self initialSetUp];
}

-(void)initialSetUp
{
    url = [NSURL URLWithString:kTopFreeAppsJsonFeed];
    data = [NSData dataWithContentsOfURL:url];
    
    
    NSError *error;
    jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                     options:kNilOptions error:&error];
    feedArray = [NSArray arrayWithArray:[jsonDictionary valueForKeyPath:@"feed.entry"]];

}

-(void)testData
{
     XCTAssertNotNil(data, @"Data not loaded from url");
}

-(void)testDict
{
     XCTAssertNotNil(jsonDictionary, @"Parsing error");
}

-(void)testFeedArray
{
    XCTAssertNotNil(feedArray, @"App Data Not Found");
}

-(void)testInitAppData
{
    for (NSDictionary *appEntry in feedArray)
    {
        AppData *appData = [[AppData alloc] initAppDataFromDictionary:appEntry];
        XCTAssertNotNil(appData.appName, @"App name is nil");
        XCTAssertNotNil(appData.category, @"App category is nil");
        XCTAssertNotNil(appData.price, @"App price is nil");
        XCTAssertNotNil(appData.releaseDate, @"App release date is nil");
        XCTAssertNotNil(appData.summary, @"App summary is nil");
        XCTAssertNotNil(appData.copyright, @"App copyright is nil");
        XCTAssertNotNil(appData.imageUrlString, @"App image url is nil");
        XCTAssertNotNil(appData.authorName, @"App author name url is nil");
    }
}

@end
