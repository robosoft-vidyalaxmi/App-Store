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

-(void) parseAppDataUsingFeed:(NSURL *) jsonFeedURL;

@end
