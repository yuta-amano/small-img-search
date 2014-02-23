//
//  BingImageSearchDelegate.h
//  small-img-search
//
//  Created by Amano Yuta on 2/23/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BingImageSearchDelegate <NSObject>

- (void)finishLoading:(NSDictionary *)data;

@end
