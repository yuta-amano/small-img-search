//
//  BingImageSearchAPI.h
//  small-img-search
//
//  Created by Amano Yuta on 2/23/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BingImageSearchDelegate.h"

@interface BingImageSearchAPI : NSObject<NSURLConnectionDataDelegate>

+ (id)requestWithQuery:(NSString *)query key:(NSString *)key delegate:(id<BingImageSearchDelegate>)delegate;

- (id)initWithKeyAndDelegate:(NSString *)key delegate:(id<BingImageSearchDelegate>)delegate;

- (void)startSearchWithQuery:(NSString *)query;

@end
