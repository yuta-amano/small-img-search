//
//  MainViewController.m
//  small-img-search
//
//  Created by Amano Yuta on 3/2/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import "MainViewController.h"
#import "DownloadImageCellView.h"
#import "SearchedImageRepository.h"

@interface MainViewController ()

@property SearchedImageRepository *searchedImageRepos;
@property SearchedImage *selectedImage;

@end

@implementation MainViewController

-(NSString *)windowNibName {
    return @"SmallImgSearch";
}

- (void)windowDidLoad {
    [super windowDidLoad];
    _searchedImageRepos = [[SearchedImageRepository alloc] init];
    _selectedImage = nil;
}

// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _searchedImageRepos.count;
}

// This method is optional if you use bindings to provide the data
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
    DownloadImageCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    SearchedImage *imgData = [_searchedImageRepos getAt:row];
    [cellView setImageData:imgData];
    return cellView;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return [tableView rowHeight];
}

- (void)showSelectedImageData {
    [_selectedImageView setHidden:NO];
    [_selectedImageSiteLabel setHidden:NO];
    [_selectedImageFilesizeLabel setHidden:NO];
    [_selectedImagePixelsizeLabel setHidden:NO];
}

- (void)hideSelectedImageData {
    [_selectedImageView setHidden:YES];
    [_selectedImageSiteLabel setHidden:YES];
    [_selectedImageFilesizeLabel setHidden:YES];
    [_selectedImagePixelsizeLabel setHidden:YES];
}

- (IBAction)onClickSearch:(id)sender {
    [_searchedImageRepos clearAll];
    [_searchedImageTableView reloadData];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *key = [prefs objectForKey:@"api_key"];
    [_searchedImageRepos loadWithQuery:_searchTextField.stringValue key:key callback:^{
        [_searchedImageTableView reloadData];
    }];
}

- (IBAction)onSelectRow:(id)sender {
    NSUInteger row = [_searchedImageTableView selectedRow];
    _selectedImage = [_searchedImageRepos getAt:row];
    _selectedImageView.image = [[NSImage alloc] initWithData:_selectedImage.imageData];
    _selectedImageSiteLabel.stringValue = _selectedImage.url;
    _selectedImageFilesizeLabel.stringValue = [NSString stringWithFormat:@"%lu", (unsigned long)_selectedImage.filesize];
    _selectedImagePixelsizeLabel.stringValue = [NSString stringWithFormat:@"%lu x %lu", (unsigned long)_selectedImage.width, (unsigned long)_selectedImage.height];
    [self showSelectedImageData];
}

- (IBAction)onClickCopyUrl:(id)sender {
    NSPasteboard *board = [NSPasteboard generalPasteboard];
    [board clearContents];
    [board setString:_selectedImage.url forType:NSPasteboardTypeString];
}

@end
