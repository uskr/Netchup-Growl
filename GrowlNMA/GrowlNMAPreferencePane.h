//
//  GrowlNMAPreferencePane.h
//
//  Growl-NMA
//  An action style for Growl 2.0 and higher that forwards messages to the NotifyMyAndroid notification service.
//
//  Created by Igor Sales on 28/11/12.
//  This work is licensed under a Creative Commons Attribution 3.0 Unported License.
//  http://creativecommons.org/licenses/by/3.0/deed.en_US


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
