//
//  SearchedImage.h
//  small-img-search
//
//  Created by Amano Yuta on 3/2/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchedImage : NSObject<NSURLConnectionDataDelegate>

@property (readonly) NSUInteger width;
@property (readonly) NSUInteger height;
@property (readonly) NSUInteger filesize;
@property (retain, readonly) NSString *url;
@property (retain, readonly) NSData *imageData;

- (id)initWithJson:(NSDictionary *)json;
- (void)loadImage:(void(^)(NSData *))callback;

@end
