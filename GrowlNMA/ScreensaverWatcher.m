/* Copyright (c) 2013 Netchup. All rights reserved.
 * Authors: Adriano Maia and Igor Sales
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

//
//  ScreensaverWatcher.m
//  GrowlNMA
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
