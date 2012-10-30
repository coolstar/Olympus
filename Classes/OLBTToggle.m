#import "OLBTToggle.h"
#import <objc/runtime.h>

@interface BluetoothManager : NSObject
+ (BluetoothManager *)sharedInstance;
- (BOOL)setEnabled:(BOOL)arg1;
- (BOOL)enabled;
@end 

@interface BBBulletinRequest : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *sectionID;
@end

@interface SBBulletinBannerController : NSObject
+ (SBBulletinBannerController *)sharedInstance;
- (void)observer:(id)observer addBulletin:(BBBulletinRequest *)bulletin forFeed:(int)feed;
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
	[btMan setEnabled:flippedBit];

	NSString *body = [NSString stringWithFormat:@"Bluetooth %@", (([btMan enabled]) ? @"enabled" : @"disabled")];

	Class bulletinBannerController = objc_getClass("SBBulletinBannerController");
	Class bulletinRequest = objc_getClass("BBBulletinRequest");
	
	BBBulletinRequest *request = [[[bulletinRequest alloc] init] autorelease];
	request.title = @"Olympus";
	request.message = body;
	request.sectionID = @"com.apple.Preferences";

	[(SBBulletinBannerController *)[bulletinBannerController sharedInstance] observer:nil addBulletin:request forFeed:2];

	[self activityDidFinish:YES];
	[p drain];
}

@end
