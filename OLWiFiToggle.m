#import "OLWiFiToggle.h"
#import <SpringBoard/SBWiFiManager.h>

@implementation OLWiFiToggle
{
}

- (void)setWiFiManager:(SBWiFiManager *)manager
{
	//_wiFiManager = manager;
}

- (NSString *)activityType
{
	return @"OLToggleWiFi";
}

- (NSString *)activityTitle
{
	return @"WiFi";
}

- (UIImage *)activityImage
{
	return nil;//[UIImage imageWithContentsOfFile:@"/var/mobile/Library/SBSettings/Themes/Serious SBSettings HD/Wi-Fi/on.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
	[super prepareWithActivityItems:activityItems];
}

- (void)performActivity
{
	//I should've written a macro for this. But meh.
	BOOL flippedBit = YES;

	if ([(SBWiFiManager *) [objc_getClass("SBWiFiManager") sharedInstance] respondsToSelector:@selector(wiFiEnabled)])
		flippedBit = !([(SBWiFiManager *) [objc_getClass("SBWiFiManager") sharedInstance] wiFiEnabled]);
		//			 ^ is a boolean NOT operator, and get's the opposite of the BOOL in question, for those of you who are new to this :)

	if ([(SBWiFiManager *) [objc_getClass("SBWiFiManager") sharedInstance] respondsToSelector:@selector(setWiFiEnabled:)])
		[[objc_getClass("SBWiFiManager") sharedInstance] setWiFiEnabled:flippedBit];
	
	[self activityDidFinish:YES];
	return;
}

@end
