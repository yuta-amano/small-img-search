//
//  AppDelegate.m
//  small-img-search
//
//  Created by Amano Yuta on 2/22/14.
//  Copyright (c) 2014 Amano Yuta. All rights reserved.
//

#import "AppDelegate.h"
#import "BingImageSearchAPI.h"
#import "MainViewController.h"

@interface AppDelegate()

@property NSWindowController *controller;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *key = [prefs objectForKey:@"api_key"];
    if (key.length == 0) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Bing Search API Key"
                                     defaultButton:nil
                                   alternateButton:nil
                                       otherButton:nil
                         informativeTextWithFormat:@"Please input Bing Search API Key."];
        NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
        [alert setAccessoryView:input];
        NSInteger button = [alert runModal];
        if (button == NSAlertDefaultReturn) {
            [prefs setObject:input.stringValue forKey:@"api_key"];
            key = input.stringValue;
        }
    }
    _controller = [[MainViewController alloc] init];
    [_controller showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
