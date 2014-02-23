//
//  DownloadImageCellView.h
//  small-img-search
//
//  Created by Amano Yuta on 3/1/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SearchedImage.h"

@interface DownloadImageCellView : NSTableCellView

@property (assign) IBOutlet NSProgressIndicator *indicator;

- (void)setImageData:(SearchedImage *)data;

@end
