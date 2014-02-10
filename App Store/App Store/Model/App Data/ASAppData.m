//
//  AppData.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "ASAppData.h"

@implementation ASAppData

- (id)initFromDictionary:(NSDictionary *)appDictionary
{
    if (self = [super init])
    {
        if (appDictionary)
        {
            _appDetailsDictionary = appDictionary;
            _appName = [appDictionary valueForKeyPath:@"im:name.label"];
            _authorName = [appDictionary valueForKeyPath:@"im:artist.label"];
            _category = [appDictionary valueForKeyPath:@"category.attributes.label"];
            _copyright = [appDictionary valueForKeyPath:@"rights.label"];
            _link = [appDictionary valueForKeyPath:@"link.attributes.href"];
            _price = [appDictionary valueForKeyPath:@"im:price.label"];
            _releaseDate = [appDictionary valueForKeyPath:@"im:releaseDate.attributes.label"];
            _summary = [appDictionary valueForKeyPath:@"summary.label"];
            _imageUrl = [NSURL URLWithString:[[[appDictionary valueForKey:@"im:image"] objectAtIndex:0] valueForKey:@"label"]];
        }
    }
    return self;
}

- (id)init
{
    return [self initFromDictionary:nil];
}

@end
