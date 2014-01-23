//
//  JSONParser.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject

@property (nonatomic, strong) NSDictionary *jsonDictionary;
@property (nonatomic, strong) NSMutableArray *appDataArray;

-(NSArray *) parseAppDataUsingFeed:(NSString *) jsonFeed;

@end
