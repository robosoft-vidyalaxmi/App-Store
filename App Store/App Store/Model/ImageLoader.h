//
//  AsynchronousImageLoader.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 30/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageLoaderDelegate <NSObject>

-(void)updateImageForCell:(id)cell withData:(NSData *)data;

@end

@interface ImageLoader : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) id cell;
@property (nonatomic, assign) id<ImageLoaderDelegate> delegate;

-(void)loadImageAsynchronouslyForURL:(NSString *)imageUrlString forCell:(id)cell;

@end
