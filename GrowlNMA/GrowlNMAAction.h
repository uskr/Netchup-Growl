/* Copyright (c) 2013 Netchup. All rights reserved.
 * Authors: Adriano Maia and Igor Sales
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

//
//  GrowlNMAAction.h
//
//  Growl-NMA
//  An action style for Growl 2.0 and higher that forwards messages to the Netchup notification service.
//


#import <GrowlPlugins/GrowlActionPlugin.h>
#import "GrowlNMAPreferencePane.h"

extern NSString * const kGrowlNMAServer;

@interface GrowlNMAAction : GrowlActionPlugin <GrowlDispatchNotificationProtocol>

- (BOOL) sendNMANotificationWithGrowlNotification:(NSDictionary *)notification configuration:(NSDictionary *)configuration;
- (BOOL) processErrorFromJSONData:(NSData*)jsonData;
int64_t SystemIdleTime(void);

@end
