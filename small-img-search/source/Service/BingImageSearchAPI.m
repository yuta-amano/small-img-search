//
//  BingImageSearchAPI.m
//  small-img-search
//
//  Created by Amano Yuta on 2/23/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import "BingImageSearchAPI.h"

@interface BingImageSearchAPI()

@property NSMutableData *receivedData;
@property id<BingImageSearchDelegate> delegate;
@property NSString *key;

@end

@implementation BingImageSearchAPI

static NSString* const API_URL = @"https://api.datamarket.azure.com/Bing/Search/v1/Image?Query=%@&$format=json";

+ (id)requestWithQuery:(NSString *)query key:(NSString *)key delegate:(id<BingImageSearchDelegate>)delegate {
    BingImageSearchAPI *instance = [[BingImageSearchAPI alloc] initWithKeyAndDelegate:key delegate:delegate];
    if (instance == nil) {
        return nil;
    }
    [instance startSearchWithQuery:query];
    return instance;
}

- (id)initWithKeyAndDelegate:(NSString *)key delegate:(id<BingImageSearchDelegate>)delegate {
    if (!(self = [super init])) {
        return nil;
    }
    _receivedData = [[NSMutableData alloc] initWithLength:0];
    _key = key;
    _delegate = delegate;
    return self;
}

- (void)startSearchWithQuery:(NSString *)query {
    NSString *encodedQuery = [self encodeQuery:[NSString stringWithFormat:@"'%@'", query]];
    NSString *url = [NSString stringWithFormat:API_URL, encodedQuery];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.f];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection == nil) {
        NSLog(@"BingImageSearchAPI:NSURLConnection initialization error");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"bing search api error:%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *err = nil;
    id json = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&err];
    if (err != nil) {
        NSLog(@"error%@", err);
    }
    [_delegate finishLoading:json];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
        newCredential = [NSURLCredential credentialWithUser:_key
                                                   password:_key
                                                persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        NSLog(@"BingImageSearchAPI: authentication error");
    }
}

- (NSString *)encodeQuery:(NSString *)query {
    CFStringRef origin = (__bridge CFStringRef)query;
    CFStringRef encodedString = CFURLCreateStringByAddingPercentEscapes(
                                    kCFAllocatorDefault,
                                    origin,
                                    NULL,
                                    CFSTR(":/?#[]@!$&'()*+,;="),
                                    kCFStringEncodingUTF8);
    NSString *ret = (__bridge NSString *)encodedString;
    CFRelease(encodedString);
    return ret;
}

@end
