//
//  AppData.m
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 22/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import "AppData.h"

@implementation AppData

-(id)initAppDataFromDictionary:(NSDictionary *)appDictionary
{
    if (self = [super init])
    {
        self.appDetailsDictionary = appDictionary;
        self.appName = [appDictionary valueForKeyPath:@"im:name.label"];
        self.authorName = [appDictionary valueForKeyPath:@"im:artist.label"];
        self.category = [appDictionary valueForKeyPath:@"category.attributes.label"];
        self.copyright = [appDictionary valueForKeyPath:@"rights.label"];
        self.link = [appDictionary valueForKeyPath:@"link.attributes.href"];
        self.price = [appDictionary valueForKeyPath:@"im:price.label"];
        self.releaseDate = [appDictionary valueForKeyPath:@"im:releaseDate.attributes.label"];
        self.summary = [appDictionary valueForKeyPath:@"summary.label"];
        self.imageUrlString = [[[appDictionary valueForKey:@"im:image"] objectAtIndex:0] valueForKey:@"label"];
    }
    return self;
}

@end
