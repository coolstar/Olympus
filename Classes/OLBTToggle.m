#import "OLBTToggle.h"
#import <objc/runtime.h>
#import "BannerClasses.h"

@interface BluetoothManager : NSObject
+ (BluetoothManager *)sharedInstance;
- (BOOL)setEnabled:(BOOL)arg1;
- (BOOL)enabled;
@end 

@implementation OLBTToggle

- (NSString *)activityType
{
	return @"OLToggleBluetooth";
}

- (NSString *)activityTitle
{
	return @"Bluetooth";
}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:@"olympus_bluetooth.png"];
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
	BluetoothManager *btMan = [objc_getClass("BluetoothManager") sharedInstance];
	BOOL flippedBit = ![btMan enabled]; //assign to opposite of current Bluetooth state
	
	NSString *body;

	if ([btMan enabled])
		body = [NSString stringWithFormat:@"Bluetooth disabled"];
	else
		body = [NSString stringWithFormat:@"Bluetooth enabled"];
	//this has to be done, because it takes time for the enabled property to be updated by the BluetoothManager. Oh well...

	[btMan setEnabled:flippedBit];

	Class bulletinBannerController = objc_getClass("SBBulletinBannerController");
	Class bulletinRequest = objc_getClass("BBBulletinRequest");
	
	BBBulletinRequest *request = [[[bulletinRequest alloc] init] autorelease];
	request.title = @"Olympus";
	request.message = body;
	request.sectionID = @"com.apple.Preferences";

	[(SBBulletinBannerController *)[bulletinBannerController sharedInstance] observer:nil addBulletin:request forFeed:2];

	[p drain];
}

@end
