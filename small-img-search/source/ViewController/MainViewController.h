//
//  MainViewController.h
//  small-img-search
//
//  Created by Amano Yuta on 3/2/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainViewController : NSWindowController<NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTableView *searchedImageTableView;
@property (strong) IBOutlet NSSearchField *searchTextField;
@property (strong) IBOutlet NSImageView *selectedImageView;
@property (strong) IBOutlet NSTextField *selectedImageSiteLabel;
@property (strong) IBOutlet NSTextField *selectedImageFilesizeLabel;
@property (strong) IBOutlet NSTextField *selectedImagePixelsizeLabel;

@end
