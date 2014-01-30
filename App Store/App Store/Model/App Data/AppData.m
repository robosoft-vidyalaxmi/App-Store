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
        self.appName = [[appDictionary valueForKey:@"im:name"] valueForKey:@"label"];
        self.authorName = [[appDictionary valueForKey:@"im:artist"] valueForKey:@"label"];
        self.category = [[[appDictionary valueForKey:@"category"] valueForKey:@"attributes"] valueForKey:@"label"];
        self.copyright = [[appDictionary valueForKey:@"rights"] valueForKey:@"label"];
        self.link = [[[appDictionary valueForKey:@"link"] valueForKey:@"attributes"] valueForKey:@"href"];
        self.price = [[appDictionary valueForKey:@"im:price"] valueForKey:@"label"];
        self.releaseDate = [[[appDictionary valueForKey:@"im:releaseDate"] valueForKey:@"attributes"]valueForKey:@"label"];
        self.summary = [[appDictionary valueForKey:@"summary"] valueForKey:@"label"];
        self.imageUrlString = [[[appDictionary valueForKey:@"im:image"] objectAtIndex:0] valueForKey:@"label"];
    }
    return self;
}

@end
