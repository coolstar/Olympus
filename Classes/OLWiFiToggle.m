#import "OLWiFiToggle.h"
#import "BannerClasses.h"
#import <SpringBoard/SBWiFiManager.h>

@implementation OLWiFiToggle

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
	return [UIImage imageNamed:@"olympus_wifi.png"];
	//return nil;
	//return [UIImage imageWithContentsOfFile:@"/var/mobile/Library/SBSettings/Themes/Serious SBSettings HD/Wi-Fi/on.png"];
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
	NSAutoreleasePool *p = [NSAutoreleasePool new];
	BOOL flippedBit = YES;

	if ([(SBWiFiManager *) [objc_getClass("SBWiFiManager") sharedInstance] respondsToSelector:@selector(wiFiEnabled)])
		flippedBit = !([(SBWiFiManager *) [objc_getClass("SBWiFiManager") sharedInstance] wiFiEnabled]);
		//			 ^ is a boolean NOT operator, and get's the opposite of the BOOL in question, for those of you who are new to this :)

	if ([(SBWiFiManager *) [objc_getClass("SBWiFiManager") sharedInstance] respondsToSelector:@selector(setWiFiEnabled:)])
		[[objc_getClass("SBWiFiManager") sharedInstance] setWiFiEnabled:flippedBit];

	NSString *body = [NSString stringWithFormat:@"WiFi %@", (([[objc_getClass("SBWiFiManager") sharedInstance] wiFiEnabled]) ? @"enabled" : @"disabled")];

	Class bulletinBannerController = objc_getClass("SBBulletinBannerController");
	Class bulletinRequest = objc_getClass("BBBulletinRequest");
		
	BBBulletinRequest *request = [[[bulletinRequest alloc] init] autorelease];
	request.title = @"Olympus";
	request.message = body;
	request.sectionID = @"com.apple.Preferences";

	[(SBBulletinBannerController *)[bulletinBannerController sharedInstance] observer:nil addBulletin:request forFeed:2];
	
	[p drain];
	
	[self activityDidFinish:YES];
}

@end
