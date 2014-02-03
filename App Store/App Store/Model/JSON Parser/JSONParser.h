//
//  JSONParser.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONParserDelegate <NSObject>

-(void)loadParsedData:(NSArray *)array;

@end

@interface JSONParser : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, assign) id<JSONParserDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *appDataArray;

-(void)parseAppDataUsingFeed:(NSString *)jsonFeed;

@end
