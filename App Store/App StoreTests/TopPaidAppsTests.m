//
//  TopPaidAppsTests.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 04/02/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppData.h"

@interface TopPaidAppsTests : XCTestCase
{
    NSData *data;
    NSDictionary *jsonDictionary;
    NSArray *feedArray;
}

@end

@implementation TopPaidAppsTests

- (void)setUp
{
    [super setUp];
    [self initialSetUp];
}

-(void)initialSetUp
{
    data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TopPaidAppsFeed" ofType:@"json"]];
    
    NSError *error;
    jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                     options:kNilOptions error:&error];
    feedArray = [NSArray arrayWithArray:[jsonDictionary valueForKeyPath:@"feed.entry"]];
    
}

-(void)testJsonData
{
    XCTAssert(data, @"Data should not be nil");
}

-(void)testjsonDict
{
    XCTAssert(jsonDictionary, @"Parsing error");
}

-(void)testFeedArray
{
    XCTAssert(feedArray, @"App Data Should not be nil");
}

-(void)testInitAppData
{
    for (NSDictionary *appEntry in feedArray)
    {
        AppData *appData = [[AppData alloc] initAppDataFromDictionary:appEntry];
        XCTAssert(appData.appName, @"App name should not be nil");
        XCTAssert(appData.category, @"App category should not be nil");
        XCTAssert(appData.price, @"App price should not be nil");
        XCTAssert(appData.releaseDate, @"App release date should not be nil");
        XCTAssert(appData.summary, @"App summary should not be nil");
        XCTAssert(appData.copyright, @"App copyright should not be nil");
        XCTAssert(appData.imageUrlString, @"App image url should not be nil");
        XCTAssert(appData.authorName, @"App author name url should not be nil");
    }
}

@end
