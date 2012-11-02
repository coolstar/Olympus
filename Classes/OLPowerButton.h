#import <UIKit/UIKit.h>

@interface OLPowerButton : UIActivity <UIActionSheetDelegate>
{
	UIView *_view;
	UIActionSheet *_powerActionsSheet;
}

- (OLPowerButton *)initWithView:(UIView *)view;
@end
