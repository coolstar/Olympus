#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "OlympusListener.h"
#import "OLWiFiToggle.h"

#define kWiFiManagerSharedInstance (SBWiFiManager *)[objc_getClass("SBWiFiManager") sharedInstance]

@interface SBWiFiManager : NSObject
+ (id)sharedInstance;
- (BOOL)isWiFiEnabled;
- (void)setWiFiEnabled:(BOOL)arg;
@end


@implementation OlympusListener

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
	NSLog(@"Olympus: Recieved event");
	//UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	if (!_topWindow) {
		_topWindow = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] retain];
		_topWindow.windowLevel = 1050.1f;
	}
	_topWindow.hidden = NO;
	UIViewController *vc  = [[UIViewController alloc] init];
	
	[_topWindow addSubview:vc.view];
	_wiFiToggle = [[OLWiFiToggle alloc] init];

	NSArray *activityItemsArray = [NSArray arrayWithObject:@""];
	NSArray *toggleActivitiesArray = [NSArray arrayWithObjects:_wiFiToggle, nil];

	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItemsArray applicationActivities:toggleActivitiesArray];
	[vc presentViewController:activityViewController animated:YES completion:NULL];
	
	activityViewController.completionHandler = ^(NSString *activityType, BOOL completed) {
		[vc.view removeFromSuperview];
		if ([activityViewController.view superview])
			[activityViewController.view removeFromSuperview];
		[_topWindow setHidden:YES];	
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
