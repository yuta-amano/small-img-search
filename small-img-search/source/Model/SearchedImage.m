//
//  SearchedImage.m
//  small-img-search
//
//  Created by Amano Yuta on 3/2/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import "SearchedImage.h"

@interface SearchedImage()

@property NSMutableData *receivedData;
@property (copy) void(^finishLoadCallback)(NSData *);
@property NSURLConnection *connection;

@end

@implementation SearchedImage

- (id)initWithJson:(NSDictionary *)json {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _width = [[json objectForKey:@"Width"] intValue];
    _height = [[json objectForKey:@"Height"] intValue];
    _filesize = [[json objectForKey:@"FileSize"] intValue];
    _url = [json objectForKey:@"MediaUrl"];
    _receivedData = [[NSMutableData alloc] initWithLength:0];
    _finishLoadCallback = nil;
    return self;
}

- (void)loadImage:(void (^)(NSData*))callback {
    if (_url == nil) {
        return;
    }
    _finishLoadCallback = callback;
    NSURL *requestUrl = [[NSURL alloc] initWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.f];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"SearchedImage:image load failure. %@", error);
    [_receivedData setLength:0];
    _finishLoadCallback(_imageData);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _imageData = [[NSData alloc] initWithData: _receivedData];
    [_receivedData setLength:0];
    _finishLoadCallback(_imageData);
    _finishLoadCallback = nil;
}

@end
