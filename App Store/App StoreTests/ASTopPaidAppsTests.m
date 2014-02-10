//
//  ASTopPaidAppsTests.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 05/02/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ASAppData.h"

@interface ASTopPaidAppsTests : XCTestCase
{
    NSData *data;
    NSDictionary *jsonDictionary;
    NSArray *feedArray;
}

@end

@implementation ASTopPaidAppsTests

- (void)setUp
{
    [super setUp];
    [self initialSetUp];
}

- (void)initialSetUp
{
    data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ASTopPaidAppsFeed" ofType:@"json"]];
    
    NSError *error;
    jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                     options:kNilOptions error:&error];
    feedArray = [NSArray arrayWithArray:[jsonDictionary valueForKeyPath:@"feed.entry"]];
}

- (void)testData
{
    XCTAssert(data, @"Data not loaded from url");
}

- (void)testDict
{
    XCTAssert(jsonDictionary, @"Parsing error");
}

- (void)testFeedArray
{
    XCTAssert(feedArray, @"App Data Should not be nil");
}

- (void)testInitAppData
{
    NSDictionary *appEntry = [feedArray objectAtIndex:0];
    
    ASAppData *appData = [[ASAppData alloc] initFromDictionary:appEntry];
    XCTAssertEqualObjects(appData.appName, [appEntry valueForKeyPath:@"im:name.label"], @"App name not matching with AppStore dictionary");
    XCTAssertEqualObjects(appData.category,[appEntry valueForKeyPath:@"category.attributes.label"], @"App category should not be nil");
    XCTAssertEqualObjects(appData.price,[appEntry valueForKeyPath:@"im:price.label"], @"App price should not be nil");
    XCTAssertEqualObjects(appData.releaseDate,[appEntry valueForKeyPath:@"im:releaseDate.attributes.label"], @"App release date should not be nil");
    XCTAssertEqualObjects(appData.summary,[appEntry valueForKeyPath:@"summary.label"], @"App summary should not be nil");
    XCTAssertEqualObjects(appData.copyright,[appEntry valueForKeyPath:@"rights.label"], @"App copyright should not be nil");
    XCTAssertEqualObjects(appData.imageUrl,[NSURL URLWithString:[[[appEntry valueForKey:@"im:image"] objectAtIndex:0] valueForKey:@"label"]], @"App image url should not be nil");
    XCTAssertEqualObjects(appData.authorName,[appEntry valueForKeyPath:@"im:artist.label"], @"App author name url should not be nil");
}

@end
