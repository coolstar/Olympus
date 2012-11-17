/*
*	Olympus
*	Tweak.mm
*	Copyright © 2012 Aditya KD
*	This software is licensed under the Apache License, 2.0.
*/

#import <UIKit/UIKit.h>

#import "OlympusListener.h"
#import "Classes/OLViewController.h"

#define UIApp [UIApplication sharedApplication]

@implementation OlympusListener

static NSDictionary *prefs = nil;
static BOOL socialActivitiesEnabled = YES;
static BOOL messagingEnabled = YES;

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
	if (!_topWindow) {
		_topWindow = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] retain];
		_topWindow.windowLevel = 1200.0f;
	}
	_topWindow.hidden = NO;
	OLViewController *vc  = [[OLViewController alloc] init];
	[_topWindow setRootViewController:vc];

	_wiFiToggle = [[OLWiFiToggle alloc] init];
	_airplaneToggle = [[OLAirplaneModeToggle alloc] init];
	_bluetoothToggle = [[OLBTToggle alloc] init];
	_cellularToggle = [[OLCellularToggle alloc] init];

	_powerButton = [[OLPowerButton alloc] initWithView:vc.view];
	_brightnessSlider = [[OLBrightnessSlider alloc] init];

	NSArray *activityItems = [[NSArray alloc] initWithObjects:@" ", nil];
	NSArray *toggleActivities =  [[NSArray alloc] initWithObjects:_airplaneToggle, _wiFiToggle, _bluetoothToggle, _powerButton, _cellularToggle, _brightnessSlider, nil]; 

	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:toggleActivities];

	NSMutableArray *excludedActivities = [NSMutableArray arrayWithObjects:UIActivityTypeCopyToPasteboard, nil];
	if (!socialActivitiesEnabled)
		[excludedActivities addObjectsFromArray:[NSArray arrayWithObjects:UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, nil]];

	if (!messagingEnabled)
		[excludedActivities addObjectsFromArray:[NSArray arrayWithObjects:UIActivityTypeMessage, UIActivityTypeMail, nil]];

	[activityViewController setExcludedActivityTypes:excludedActivities];
	[vc presentViewController:activityViewController animated:YES completion:NULL];

	activityViewController.completionHandler = ^(NSString *activityType, BOOL completed) {
		[_topWindow performSelector:@selector(setHidden:) withObject:self afterDelay:0.40f];

		[_wiFiToggle release];
		[_airplaneToggle release];
		[_bluetoothToggle release];
		[_cellularToggle release];
		[_powerButton release];
		[_brightnessSlider release];
		[activityItems release];
		[toggleActivities release];
		[vc release];
		[activityViewController release];
	};
	[event setHandled:YES];
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event
{
    [event setHandled:YES];
}

+ (void)load
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [[LAActivator sharedInstance] registerListener:[self new] forName:@"com.flux.olympus"];
    [pool drain];
}

@end

static void olReloadPrefs(void)
{
	[prefs release];
	prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.flux.olympusprefs.plist"];
	socialActivitiesEnabled = [[prefs objectForKey:@"Social"] boolValue];
	messagingEnabled = [[prefs objectForKey:@"Messaging"] boolValue];
}


%ctor
{
	NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	%init;
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)&olReloadPrefs, CFSTR("com.flux.olympus.reloadPrefs"), NULL, CFNotificationSuspensionBehaviorHold);
	olReloadPrefs();
	[p drain];
}
