#import "OLPowerButton.h"

@interface SpringBoard : UIApplication
- (void)powerDown;
- (void)relaunchSpringBoard;
@end

@implementation OLPowerButton

static NSInteger respringButtonIndex;
static NSInteger safeModeButtonIndex;

- (OLPowerButton *)initWithView:(UIView *)view
{
	if ((self = [super init])) {
		_view = view;
	}
	return self;
}

- (NSString *)activityType
{
	return @"OLPowerButton";
}

- (NSString *)activityTitle
{
	return @"Power";
}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:@"olympus_power.png"];
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
	_powerActionsSheet  = [[UIActionSheet alloc] initWithTitle:@"System Options" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Turn Off" otherButtonTitles:nil];
	respringButtonIndex = [_powerActionsSheet addButtonWithTitle:@"Respring"];
	safeModeButtonIndex = [_powerActionsSheet addButtonWithTitle:@"Safe Mode"];
	_powerActionsSheet.cancelButtonIndex = [_powerActionsSheet addButtonWithTitle:@"Dismiss"];
	[_powerActionsSheet showInView:_view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)index
{
	NSLog(@"Olympus clicked button index: %i", index);
	if (index == [actionSheet destructiveButtonIndex]) {
		[(SpringBoard *)[UIApplication sharedApplication] powerDown];
	}
	if (index == respringButtonIndex) {
		[(SpringBoard *)[UIApplication sharedApplication] relaunchSpringBoard];
	}
	if (index == safeModeButtonIndex) {
		system("killall -SEGV SpringBoard");
	}
}

@end
