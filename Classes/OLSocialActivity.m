#import "OLSocialActivity.h"
#import <Social/Social.h>

typedef enum {
	OLSocialNetworkTypeFacebook,
	OLSocialNetworkTypeTwitter,
} OLSocialNetworkType;

@implementation OLSocialActivity

static OLSocialNetworkType _networkType;
static UIViewController *_viewController = nil;

- (id)initWithSocialNetworkType:(NSString *)network andViewController:(UIViewController *)viewController;
{
	if ((self = [super init])) {
		if ([network isEqual:@"Twitter"])
			_networkType = OLSocialNetworkTypeTwitter;
		else if ([network isEqual:@"Facebook"])
			_networkType = OLSocialNetworkTypeFacebook;
	}
	_viewController = viewController;

	return self;
}

- (NSString *)activityType
{
	return @"OLSocialActivity";
}

- (NSString *)activityTitle
{
	NSString *title;

	switch (_networkType) {
		case OLSocialNetworkTypeTwitter:
			title = @"Twitter";
		case OLSocialNetworkTypeFacebook:
			title = @"Facebook";
		default:
			title = nil;
	}

	return title;
}

- (UIImage *)activityImage
{
	UIImage *icon;

	switch (_networkType) {
		case OLSocialNetworkTypeTwitter:
			icon = [UIImage imageNamed:@"olympus_twitter.png"];
		case OLSocialNetworkTypeFacebook:
			icon = [UIImage imageNamed:@"olympus_facebook.png"];
		default:
			icon = nil;
	}
	
	return icon;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	if (_networkType == OLSocialNetworkTypeTwitter)
		if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
			return YES;
		
	if (_networkType == OLSocialNetworkTypeFacebook) 
		if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
			return YES;

	return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
	[super prepareWithActivityItems:activityItems];
}

- (void)performActivity
{
	SLComposeViewController *socialVC;
	if (_networkType == OLSocialNetworkTypeTwitter) {
		socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
		socialVC.completionHandler = ^(SLComposeViewControllerResult result) {
			[self activityDidFinish:YES];
		};
	}
	else if (_networkType == OLSocialNetworkTypeFacebook) {
		socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
		socialVC.completionHandler = ^(SLComposeViewControllerResult result) {
			[self activityDidFinish:YES];
		};
	}

	[_viewController presentViewController:socialVC animated:YES completion:NULL];

}

@end 
