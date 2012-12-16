//
//  GrowlNMAAction.h
//
//  Growl-NMA
//  An action style for Growl 2.0 and higher that forwards messages to the NotifyMyAndroid notification service.
//
//  Created by Igor Sales on 28/11/12.
//  This work is licensed under a Creative Commons Attribution 3.0 Unported License.
//  http://creativecommons.org/licenses/by/3.0/deed.en_US

#import <GrowlPlugins/GrowlActionPlugin.h>
#import "GrowlNMAPreferencePane.h"

extern NSString * const kGrowlNMAServer;

@interface GrowlNMAAction : GrowlActionPlugin <GrowlDispatchNotificationProtocol>

- (BOOL) sendNMANotificationWithGrowlNotification:(NSDictionary *)notification configuration:(NSDictionary *)configuration;
- (BOOL) processErrorFromJSONData:(NSData*)jsonData;
int64_t SystemIdleTime(void);

@end
