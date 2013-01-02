/* Copyright (c) 2013 Netchup. All rights reserved.
 * Authors: Adriano Maia and Igor Sales
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

//
//  GrowlNMAPreferencePane.m
//
//  Growl-NMA
//  An action style for Growl 2.0 and higher that forwards messages to the Netchup notification service.
//


#import "GrowlNMAPreferencePane.h"
#import "GrowlNMAAction.h"

@implementation GrowlNMAPreferencePane

-(NSString*)mainNibName
{
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    NSString* path = [bundle pathForResource:@"GrowlNMAPrefPane" ofType:@"nib"];
    
    if (path == nil) {
        path = [bundle pathForResource:@"GrowlNMAPrefPaneOld" ofType:@"nib"];
        if (path) {
            return @"GrowlNMAPrefPaneOld";
        }
    }

	return @"GrowlNMAPrefPane";
}

/* This returns the set of keys the preference pane needs updated via bindings 
 * This is called by GrowlPluginPreferencePane when it has had its configuration swapped
 * Since we really only need a fixed set of keys updated, use dispatch_once to create the set
 */
- (NSSet*)bindingKeys {
	static NSSet *keys = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		keys = [NSSet setWithObjects:
                @"apiKey",
                @"onlyIfIdle",
                @"prefixString",
                @"minimumMinutes",
                @"onlyIfScreensaverActive",
                @"testStatus",
                nil];
        NSLog(@"BindingKeysBeingCalled");
	});
	return keys;
}

- (IBAction)testNMASettings:(id)sender
{
    [self.mainView.window makeFirstResponder:sender];
    GrowlNMAAction *action = [[GrowlNMAAction alloc] init];
    action.preferencePane = self;
    NSDictionary* testNotification = [NSDictionary dictionaryWithObjectsAndKeys: @"Test Notification", @"NotificationTitle", @"This is a test notification.", @"NotificationDescription", nil];
    [action sendNMANotificationWithGrowlNotification:testNotification configuration:self.configuration];
}

- (IBAction)openWebsite:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@/growl.php", kGrowlNMAServer]]];
}

- (NSString*)apiKey
{
    return [self.configuration valueForKey:@"apiKey"];
}

- (void)setApiKey:(NSString*)apiKey
{
    [self setConfigurationValue:apiKey forKey:@"apiKey"];
}

- (BOOL)onlyIfIdle
{
    return [[self.configuration valueForKey:@"onlyIfIdle"] boolValue];
}

- (void)setOnlyIfIdle:(BOOL)onlyIfIdle
{
    [self setConfigurationValue:[NSNumber numberWithBool:onlyIfIdle] forKey:@"onlyIfIdle"];
}

- (NSString*)prefixString
{
    return [self.configuration valueForKey:@"prefixString"];
}

- (void)setPrefixString:(NSString*)string
{
    [self setConfigurationValue:string forKey:@"prefixString"];
}

- (NSInteger)minimumMinutes
{
    NSInteger mins = [[self.configuration valueForKey:@"minimumMinutes"] integerValue];
    
    if (mins < self.minMinutes) {
        mins = self.minMinutes;
        [self.configuration setValue:[NSNumber numberWithInteger:mins] forKey:@"minimumMinutes"];
    }
    
    return mins;
}

- (void)setMinimumMinutes:(NSInteger)minutes
{
    [self setConfigurationValue:[NSNumber numberWithInteger:minutes] forKey:@"minimumMinutes"];
}

- (BOOL)onlyIfScreensaverActive
{
    return [[self.configuration valueForKey:@"onlyIfScreensaverActive"] boolValue];
}

- (void)setOnlyIfScreensaverActive:(BOOL)active
{
    [self setConfigurationValue:[NSNumber numberWithBool:active] forKey:@"onlyIfScreensaverActive"];
}

- (NSInteger)minMinutes
{
    return 1;
}

- (NSInteger)maxMinutes
{
    return 120;
}

@end
