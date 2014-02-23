//
//  SearchedImageRepository.h
//  small-img-search
//
//  Created by Amano Yuta on 3/2/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchedImage.h"
#import "BingImageSearchDelegate.h"

@interface SearchedImageRepository : NSObject<BingImageSearchDelegate>

@property (readonly) NSUInteger count;

- (id)init;
- (void)clearAll;
- (void)loadWithQuery:(NSString *)query key:(NSString *)apiKey callback:(void(^)(void))callback;
- (SearchedImage *)getAt:(NSUInteger)index;

@end
