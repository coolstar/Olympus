#import <UIKit/UIKit.h>
#import "OlympusListener.h"

@implementation OlympusListener

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
	if (!_topWindow) {
		_topWindow = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] retain];
		_topWindow.windowLevel = UIWindowLevelStatusBar;
	}
	_topWindow.hidden = NO;
	UIViewController *vc  = [[UIViewController alloc] init];
	[_topWindow addSubview:vc.view];

	_wiFiToggle = [[OLWiFiToggle alloc] init];
	_airplaneToggle = [[OLAirplaneModeToggle alloc] init];
	_bluetoothToggle = [[OLBTToggle alloc] init];

	NSArray *activityItems = [[NSArray alloc] initWithObjects:@" ", nil];
	NSArray *toggleActivities =  [[NSArray alloc] initWithObjects:_wiFiToggle, _airplaneToggle, _bluetoothToggle,nil]; //[NSArray arrayWithObjects:_wiFiToggle, _airplaneToggle, nil];

	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:toggleActivities];
	[vc presentViewController:activityViewController animated:YES completion:NULL];
	
	activityViewController.completionHandler = ^(NSString *activityType, BOOL completed) {
		[_topWindow performSelector:@selector(setHidden:) withObject:self afterDelay:0.40f];

		[_wiFiToggle release];
		[_airplaneToggle release];
		[_bluetoothToggle release];
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
