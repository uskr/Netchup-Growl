//
//  GrowlNMAPrefs.h
//
//  Copyright: 2011 Adriano Maia



#import <PreferencePanes/PreferencePanes.h>

#define NMAPrefDomain			@"com.nma.growl"

#define NMA_SCREEN_PREF			@"Screen"

#define NMA_APIKEY_PREF	 @"API Key"
#define NMA_DEFAULT_APIKEY	 @""

#define NMA_LABEL_PREF	 @"Label"
#define NMA_DEFAULT_LABEL	 @"[Growl]"


@interface GrowlNMAPrefs : NSPreferencePane {
	IBOutlet NSString *nmaApikey;
	IBOutlet NSString *nmaLabel;
}

- (NSString *) nmaApikey;
- (void) setNmaApikey:(NSString *)value;
- (NSString *) nmaLabel;
- (void) setNmaLabel:(NSString *)value;


@end
