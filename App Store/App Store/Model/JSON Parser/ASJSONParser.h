//
//  JSONParser.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASJSONParserDelegate <NSObject>

-(void)loadParsedData:(NSArray *)array;

@end

@interface ASJSONParser : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, assign) id<ASJSONParserDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *appDataArray;

-(void)parseAppDataUsingFeed:(NSString *)jsonFeed;

@end
