//
//  DownloadImageCellView.m
//  small-img-search
//
//  Created by Amano Yuta on 3/1/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import "DownloadImageCellView.h"

@interface DownloadImageCellView()

@property NSString *url;
@property NSMutableData *receivedData;

@end

@implementation DownloadImageCellView

- (void)setImageData:(SearchedImage *)data {
    self.textField.stringValue = data.url;
    [self.imageView setHidden:YES];
    [self.indicator setHidden:NO];
    [self.indicator startAnimation:self];
    [data loadImage:^(NSData *receivedData) {
        self.imageView.image = [[NSImage alloc] initWithData:receivedData];
        [self.imageView setHidden:NO];
        [self.indicator stopAnimation:self];
        [self.indicator setHidden:YES];
    }];
}


@end
