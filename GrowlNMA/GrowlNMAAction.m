//
//  GrowlNMAAction.m
//
//  Growl-NMA
//  An action style for Growl 2.0 and higher that forwards messages to the NotifyMyAndroid notification service.
//
//  Created by Igor Sales on 28/11/12.
//  This work is licensed under a Creative Commons Attribution 3.0 Unported License.
//  http://creativecommons.org/licenses/by/3.0/deed.en_US

#include <IOKit/IOKitLib.h>

#import "GrowlNMAAction.h"
#import "GrowlNMAPreferencePane.h"
#import "ScreensaverWatcher.h"

static ScreensaverWatcher* ssWatcher = nil;

@implementation GrowlNMAAction

+ (void)initialize
{
    if (ssWatcher == nil) {
        ssWatcher = [ScreensaverWatcher new];
    }
}

/* Dispatch a notification with a configuration, called on the default priority background concurrent queue
 * Unless you need to use UI, do not send something to the main thread/queue.
 * If you have a requirement to be serialized, make a custom serial queue for your own use. 
 */
-(void)dispatchNotification:(NSDictionary *)notification withConfiguration:(NSDictionary *)configuration {
    
    // are we waiting for this mac to be idle?
    if ([[configuration valueForKey:@"onlyIfIdle"] boolValue] && SystemIdleTime() < [[configuration valueForKey:@"minimumMinutes"] intValue] * 60) {
        // system idle for less than 5 minutes. do not notify.
        return;
    }
    // do we need to wait for a specific priority?
    if ([[configuration valueForKey:@"onlyIfScreensaverActive"] boolValue] && !ssWatcher.isScreensaverActive) {
        // notification does not meet minimum priority. do not notify.
        return;
    }
    
    [self sendNMANotificationWithGrowlNotification:notification configuration:configuration];
}

- (NSString*)encodeURIString:(NSString*)s
{
    return [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL) sendNMANotificationWithGrowlNotification:(NSDictionary *)notification configuration:(NSDictionary *)configuration {
    
    NSString* apiKey = [configuration valueForKey:@"apiKey"];
    NSString* text   = [notification valueForKey:@"NotificationDescription"];
    NSString* event  = [notification valueForKey:@"NotificationName"];
    NSString* appname = [notification valueForKey:@"ApplicationName"];

    int prio = [[notification valueForKey:@"NotificationPriority"] intValue];
    if (prio < -2) {
        prio = -2;
    } else if (prio > 2) {
        prio = 2;
    }
    
    NSString* prefix = [configuration valueForKey:@"prefixString"];
    if (prefix.length) {
        appname = [prefix stringByAppendingString:appname];
    }

    NSString *postContent = [NSString stringWithFormat:@"apikey=%@&application=%@&event=%@&description=%@&priority=%d",
                             [self encodeURIString:apiKey],
                             [self encodeURIString:appname],
                             [self encodeURIString:event],
                             [self encodeURIString:text],
                             prio];

    NSURL *url = [NSURL URLWithString:@"https://notifymyandroid-dev.appspot.com/publicapi/notify"];
	//NSURL *url = [NSURL URLWithString:@"https://www.notifymyandroid.com/publicapi/notify"];

	NSMutableURLRequest *theRequest = (NSMutableURLRequest*)[[NSMutableURLRequest alloc] initWithURL:url];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody:[postContent dataUsingEncoding:NSUTF8StringEncoding]];
	NSURLResponse* response;
	NSError *error = nil;
	NSData *result = [NSURLConnection sendSynchronousRequest:theRequest
										   returningResponse:&response
													   error:&error];
	if(error) {
		NSLog(@"NMA connection error = %@", error);
        return NO;
    }
	
	NSString *resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
	NSLog(@"NMA result: %@", resultString);
    
    ((GrowlNMAPreferencePane*)self.preferencePane).testStatus = resultString;
    
    return YES;
}

- (BOOL) processErrorFromJSONData:(NSData*)jsonData {
    
    NSError *jsonError;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
    if (!responseDict && jsonError) { return FALSE; }
    
    ((GrowlNMAPreferencePane*)self.preferencePane).testStatus = [[[responseDict objectForKey:@"errors"] firstObject] capitalizedString];
    
    return TRUE;
}

#pragma mark System Idle Time Methods

/**
Thanks to Dan at http://www.danandcheryl.com/2010/06/how-to-check-the-system-idle-time-using-cocoa)
for the following SystemIdleTime() method.
**/

int64_t SystemIdleTime(void) {
    int64_t idlesecs = -1;
    io_iterator_t iter = 0;
    if (IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IOHIDSystem"), &iter) == KERN_SUCCESS) {
        io_registry_entry_t entry = IOIteratorNext(iter);
        if (entry) {
            CFMutableDictionaryRef dict = NULL;
            if (IORegistryEntryCreateCFProperties(entry, &dict, kCFAllocatorDefault, 0) == KERN_SUCCESS) {
                CFNumberRef obj = CFDictionaryGetValue(dict, CFSTR("HIDIdleTime"));
                if (obj) {
                    int64_t nanoseconds = 0;
                    if (CFNumberGetValue(obj, kCFNumberSInt64Type, &nanoseconds)) {
                        idlesecs = (nanoseconds >> 30); // Divide by 10^9 to convert from nanoseconds to seconds.
                    }
                }
                CFRelease(dict);
            }
            IOObjectRelease(entry);
        }
        IOObjectRelease(iter);
    }
    return idlesecs;
}

#pragma mark Required Growl Preference Methods

/* Auto generated method returning our PreferencePane, do not touch */
- (GrowlPluginPreferencePane *) preferencePane {
	if (!preferencePane)
		preferencePane = [[GrowlNMAPreferencePane alloc] initWithBundle:[NSBundle bundleWithIdentifier:@"ca.igorsales.GrowlNMA"]];
	
	return preferencePane;
}

@end
