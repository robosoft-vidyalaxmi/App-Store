//
//  AppData.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAppData : NSObject

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString  *imageUrlString;
@property (nonatomic, strong) NSDictionary *appDetailsDictionary;

-(id)initAppDataFromDictionary:(NSDictionary *)appDictionary;

@end
