#import "OLWiFiToggle.h"

@interface SBWiFiManager : NSObject
- (void)setWiFiEnabled:(BOOL)arg1;
@end

@implementation OLWiFiToggle
{
}

- (void)setWiFiManager:(id)manager
{
	_wiFiManager = manager;
}

/*UIActivity subclass mandatory overrides*/

- (NSString *)activityType
{
	return @"wat";
}

- (NSString *)activityTitle
{
	return @"WiFi";
}

- (UIImage *)activityImage
{
	return nil;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{

}

- (void)performActivity
{
	[(SBWiFiManager *)_wiFiManager setWiFiEnabled:YES];
}

@end
