/*
*	Olympus
*	Tweak.mm
*	Copyright © 2012 Aditya KD
*	This software is licensed under the Apache License, 2.0.
*/

#import "OlympusListener.h"

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBAppSwitcherModel.h>
#import <SpringBoard/SBApplication.h>

#define UIApp [UIApplication sharedApplication]

@interface OlympusListener (Private)
- (void)tellTopAppToResignActive;
- (void)tellTopAppToResumeActive;
@end

@implementation OlympusListener
@synthesize shouldEditCancelButtonText;

// static variables.
static NSDictionary *prefs = nil;

static BOOL isBeingDisplayed = NO;
static BOOL socialActivitiesEnabled = YES;
static BOOL messagingEnabled = YES;
static BOOL shouldDismissAfterAction = YES;

+ (OlympusListener *)sharedInstance
{
	static OlympusListener *listener;
	if (!listener)
		listener = [self new];
	return listener;
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
	if (isBeingDisplayed) {
		[event setHandled:YES];
		return;
	}

	if (!_topWindow) {
		_topWindow = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] retain];
		_topWindow.windowLevel = 1200.0f;
	}
	_topWindow.hidden = NO;
	OLViewController *vc  = [[OLViewController alloc] init];
	[_topWindow setRootViewController:vc];

	[self tellTopAppToResignActive];

	_wiFiToggle = [[[OLWiFiToggle alloc] init] autorelease];
	_airplaneToggle = [[[OLAirplaneModeToggle alloc] init] autorelease];
	_bluetoothToggle = [[[OLBTToggle alloc] init] autorelease];
	_cellularToggle = [[[OLCellularToggle alloc] init] autorelease];

	_powerButton = [[[OLPowerButton alloc] initWithView:vc.view] autorelease];
	_brightnessSlider = [[[OLBrightnessSlider alloc] init] autorelease];

	NSArray *activityItems = [[NSArray alloc] initWithObjects:@" ", nil];
	NSArray *toggleActivities =  [[NSArray alloc] initWithObjects:_airplaneToggle, _wiFiToggle, _bluetoothToggle, _powerButton, _brightnessSlider, _cellularToggle, nil];

	shouldEditCancelButtonText = YES;
	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:toggleActivities];

	NSMutableArray *excludedActivities = [NSMutableArray arrayWithObjects:UIActivityTypeCopyToPasteboard, nil];
	if (!socialActivitiesEnabled)
		[excludedActivities addObjectsFromArray:[NSArray arrayWithObjects:UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, nil]];

	if (!messagingEnabled)
		[excludedActivities addObjectsFromArray:[NSArray arrayWithObjects:UIActivityTypeMessage, UIActivityTypeMail, nil]];

	[activityViewController setExcludedActivityTypes:excludedActivities];
	[vc presentViewController:activityViewController animated:YES completion:NULL];
	isBeingDisplayed =  YES;

	activityViewController.completionHandler = ^(NSString *activityType, BOOL completed) {
		[_topWindow performSelector:@selector(setHidden:) withObject:self afterDelay:0.40f]; // delay is for the animation to complete.
		[toggleActivities release];
		[vc release];
		[activityViewController release];

		[self tellTopAppToResumeActive];
		shouldEditCancelButtonText = NO;
		isBeingDisplayed = NO;
	};
	[event setHandled:YES];
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event
{
    [event setHandled:YES];
}

- (void)tellTopAppToResignActive
{
	SBApplication *topApp = [(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication];
	// returns nil if SpringBoard is visible. Cool.
	if (topApp != nil) {
		[topApp notifyResignActiveForReason:1];
	}
}

- (void)tellTopAppToResumeActive
{
	SBApplication *topApp = [(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication];
	if (topApp != nil) {
		[topApp notifyResumeActiveForReason:1];
	}
}

+ (void)load
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [[LAActivator sharedInstance] registerListener:[self sharedInstance] forName:@"com.flux.olympus"];
    [pool drain];
}

@end

static void OLReloadPrefs(void)
{
	[prefs release];
	prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.flux.olympusprefs.plist"];
	socialActivitiesEnabled = [[prefs objectForKey:@"Social"] boolValue];
	messagingEnabled = [[prefs objectForKey:@"Messaging"] boolValue];
	shouldDismissAfterAction = [[prefs objectForKey:@"DismissAfterAction"] boolValue];
}


// hook for the UIActivityViewController's CancelButton
@interface UIActivityCancelButton : UIButton
- (void)layoutSubviews;
@end

%hook UIActivityCancelButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
	if ([[OlympusListener sharedInstance] shouldEditCancelButtonText])
		%orig(@"Dismiss", state);
	else
		%orig(title, state);
}
%end



%ctor
{
	NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	%init;
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), 
									NULL,
									(CFNotificationCallback)&OLReloadPrefs,
									CFSTR("com.flux.olympus.reloadPrefs"),
									NULL,
									CFNotificationSuspensionBehaviorHold);
	OLReloadPrefs();
	[p drain];
}