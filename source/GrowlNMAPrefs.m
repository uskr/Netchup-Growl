//
//  GrowlNMAPrefs.m
//
//  Copyright: 2011 Adriano Maia



#import "GrowlNMAPrefs.h"
#import "GrowlDefinesInternal.h"


@implementation GrowlNMAPrefs

- (NSString *) mainNibName {
	return @"GrowlNMAPrefs";
}

- (void) mainViewDidLoad {
	// do something
}

- (void) didSelect {
	SYNCHRONIZE_GROWL_PREFS();
}

/*- (NSString *) notifoUsername {
	NSString *value = nil;
	READ_GROWL_PREF_VALUE(NMA_USERNAME_PREF, NMAPrefDomain, NSString *, &value);
	return value;
}
- (void) setNMAUsername:(NSString *)value {
	if (value == NULL) {
		value = @"";
	}
	WRITE_GROWL_PREF_VALUE(NMA_USERNAME_PREF, value, NMAPrefDomain);
	UPDATE_GROWL_PREFS();
}*/

- (NSString *) nmaApikey {
	NSString *value = nil;
	READ_GROWL_PREF_VALUE(NMA_APIKEY_PREF, NMAPrefDomain, NSString *, &value);
	return value;
}
- (void) setNmaApikey:(NSString *)value {
	if (value == NULL) {
		value = @"";
	}
	WRITE_GROWL_PREF_VALUE(NMA_APIKEY_PREF, value, NMAPrefDomain);
	UPDATE_GROWL_PREFS();
}

- (NSString *) nmaLabel {
	NSString *value = nil;
	READ_GROWL_PREF_VALUE(NMA_LABEL_PREF, NMAPrefDomain, NSString *, &value);
	return value;
}
- (void) setNmaLabel:(NSString *)value {
	if (value == NULL) {
		value = @"";
	}
	WRITE_GROWL_PREF_VALUE(NMA_LABEL_PREF, value, NMAPrefDomain);
	UPDATE_GROWL_PREFS();
}

@end
