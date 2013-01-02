/* Copyright (c) 2013 Netchup. All rights reserved.
 * Authors: Adriano Maia and Igor Sales
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

//
//  GrowlNMAPreferencePane.h
//
//  Growl-NMA
//  An action style for Growl 2.0 and higher that forwards messages to the Netchup notification service.
//


#import <GrowlPlugins/GrowlPluginPreferencePane.h>

@interface GrowlNMAPreferencePane : GrowlPluginPreferencePane

@property (nonatomic, copy)             NSString* testStatus;
@property (nonatomic, assign, readonly) NSInteger minMinutes;
@property (nonatomic, assign, readonly) NSInteger maxMinutes;

@property (nonatomic, copy)             NSString* apiKey;
@property (nonatomic, assign)           BOOL      onlyIfIdle;
@property (nonatomic, copy)             NSString* prefixString;
@property (nonatomic, assign)           NSInteger minimumMinutes;
@property (nonatomic, assign)           BOOL      onlyIfScreensaverActive;

- (IBAction)testNMASettings:(id)sender;
- (IBAction)openWebsite:(id)sender;

@end
