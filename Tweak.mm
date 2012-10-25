#import "OlympusListener.h"

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

	NSArray *arr = [NSArray arrayWithObject:@"test"];
	UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:arr applicationActivities:nil];
	[vc presentViewController:activityViewController animated:YES completion:NULL];
	
	activityViewController.completionHandler = ^(NSString *activityType, BOOL completed) {
		//[vc.view removeFromSuperview];
		[activityViewController.view removeFromSuperview];
		[vc release];
		[activityViewController release];
		[_topWindow setHidden:YES];

		NSLog(@"%@", [_topWindow subviews]);
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
