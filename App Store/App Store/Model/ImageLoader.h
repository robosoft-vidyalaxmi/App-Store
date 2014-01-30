//
//  AsynchronousImageLoader.h
//  App Store
//
//  Created by Vidyalaxmi Shenoy on 30/01/14.
//  Copyright (c) 2014 Vidyalaxmi Shenoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppCell;

@protocol ImageLoaderDelegate <NSObject>

-(void)updateImageForCell:(AppCell *)cell withData:(NSData *)data;

@end
@interface ImageLoader : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) AppCell *appCell;
@property (nonatomic, assign) id<ImageLoaderDelegate> delegate;

-(void)loadImageAsynchronouslyForURL:(NSString *)imageUrlString forCell:(AppCell *)cell;

@end
