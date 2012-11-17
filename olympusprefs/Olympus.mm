#import <Preferences/Preferences.h>

@interface OlympusListController: PSListController {
}
@end

@implementation OlympusListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Olympus" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
