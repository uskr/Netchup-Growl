//
//  ScreensaverWatcher.m
//  GrowlNMA
//
//  Created by Igor Sales on 2012-12-14.
//  Copyright (c) 2012 Igor Sales. All rights reserved.
//

#import "ScreensaverWatcher.h"


@implementation ScreensaverWatcher

@synthesize isScreensaverActive = _isScreensaverActive;

- (id)init
{
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeScreensaveNotification:) name:@"com.apple.screensaver.didstart" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeScreensaveNotification:) name:@"com.apple.screensaver.didstop" object:nil];
    }

    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)observeScreensaverNotification:(NSNotification*)notification
{
    if ([notification.name isEqualToString:@"com.apple.screensaver.didstart"]) {
        _isScreensaverActive = YES;
    } else if ([notification.name isEqualToString:@"com.apple.screensaver.didstop"]) {
        _isScreensaverActive = NO;
    }
}

@end
