#import "OLCellularToggle.h"

void CTRegistrationSetCellularDataIsEnabled(void);

@implementation OLCellularToggle
- (NSString *)activityType
{
	return @"OLToggleCellular";
}

- (NSString *)activityTitle
{
	return @"Data";
}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:@"olynpus_cellular.png"];
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
	CTRegistrationSetCellularDataIsEnabled();
}

@end