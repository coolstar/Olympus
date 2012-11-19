#import "OLAirplaneModeToggle.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "BannerClasses.h"

@interface SBTelephonyManager : NSObject
+ (id)sharedTelephonyManager;
- (BOOL)isInAirplaneMode;
- (void)setIsInAirplaneMode:(BOOL)arg1;
@end

@implementation OLAirplaneModeToggle

- (NSString *)activityType
{
	return @"OLToggleAirplaneMode";
}

- (NSString *)activityTitle
{
	return @"Airplane Mode";
}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:@"olympus_airplane.png"];
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
	SBTelephonyManager *telMan = (SBTelephonyManager *)[objc_getClass("SBTelephonyManager") sharedTelephonyManager];
	BOOL flippedBit = ![telMan isInAirplaneMode];
	[telMan setIsInAirplaneMode:flippedBit];

	NSString *body = [NSString stringWithFormat:@"Airplane mode %@", ([telMan isInAirplaneMode] ? @"enabled" : @"disabled")];

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
