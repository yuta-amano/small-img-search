//
//  SearchedImageRepository.m
//  small-img-search
//
//  Created by Amano Yuta on 3/2/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import "SearchedImageRepository.h"
#import "BingImageSearchAPI.h"

@interface SearchedImageRepository()

@property NSMutableArray *images;
@property (copy) void(^finishLoadCallback)();

@end

@implementation SearchedImageRepository

- (id)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _images = [[NSMutableArray alloc] init];
    _finishLoadCallback = nil;
    _count = 0;
    return self;
}

- (void)clearAll {
    [_images removeAllObjects];
    _count = 0;
}

- (void)loadWithQuery:(NSString *)query key:(NSString *)apiKey callback:(void (^)(void))callback {
    if (_images.count > 0) {
        [_images removeAllObjects];
    }
    _finishLoadCallback = callback;
    _count = 0;
    [BingImageSearchAPI requestWithQuery:query key:apiKey delegate:self];
}

- (SearchedImage *)getAt:(NSUInteger)index {
    return _images[index];
}

- (void)finishLoading:(NSDictionary *)data {
    NSArray *image_data = data[@"d"][@"results"];
    for (id img in image_data) {
        SearchedImage *searched_img = [[SearchedImage alloc] initWithJson:img];
        [_images addObject:searched_img];
    }
    _count = image_data.count;
    _finishLoadCallback();
}

@end
