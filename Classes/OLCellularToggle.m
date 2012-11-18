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
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	return ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) ? YES : NO;
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