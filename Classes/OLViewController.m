#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "OLViewController.h"

@implementation OLViewController

- (BOOL)shoudAutoRotate
{
	return YES;
}

- (id)init
{
	self = [super init];
	if (self) {
		[[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(orientationWillChange:)
                                                 name: UIApplicationWillChangeStatusBarOrientationNotification
                                               object: nil];
    	[[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(orientationDidChange:)
                                                 name: UIApplicationDidChangeStatusBarOrientationNotification
                                               object: nil];
	}
	return self;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return [[UIApplication sharedApplication] statusBarOrientation];
}


- (void)orientationWillChange:(NSNotification *)note
{
    UIInterfaceOrientation current = [[UIApplication sharedApplication] statusBarOrientation];
    UIInterfaceOrientation orientation = [[[note userInfo] objectForKey: UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    if ( [self shouldAutorotateToInterfaceOrientation: orientation] == NO )
        return;

    if ( current == orientation )
        return;

    // direction and angle
    CGFloat angle = 0.0;
    switch ( current )
    {
        case UIInterfaceOrientationPortrait:
        {
            switch ( orientation )
            {
                case UIInterfaceOrientationPortraitUpsideDown:
                    angle = (CGFloat)M_PI;  // 180.0*M_PI/180.0 == M_PI
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                    angle = (CGFloat)(M_PI*-90.0)/180.0;
                    break;
                case UIInterfaceOrientationLandscapeRight:
                    angle = (CGFloat)(M_PI*90.0)/180.0;
                    break;
                default:
                    return;
            }
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            switch ( orientation )
            {
                case UIInterfaceOrientationPortrait:
                    angle = (CGFloat)M_PI;  // 180.0*M_PI/180.0 == M_PI
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                    angle = (CGFloat)(M_PI*90.0)/180.0;
                    break;
                case UIInterfaceOrientationLandscapeRight:
                    angle = (CGFloat)(M_PI*-90.0)/180.0;
                    break;
                default:
                    return;
            }
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        {
            switch ( orientation )
            {
                case UIInterfaceOrientationLandscapeRight:
                    angle = (CGFloat)M_PI;  // 180.0*M_PI/180.0 == M_PI
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                    angle = (CGFloat)(M_PI*-90.0)/180.0;
                    break;
                case UIInterfaceOrientationPortrait:
                    angle = (CGFloat)(M_PI*90.0)/180.0;
                    break;
                default:
                    return;
            }
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            switch ( orientation )
            {
                case UIInterfaceOrientationLandscapeLeft:
                    angle = (CGFloat)M_PI;  // 180.0*M_PI/180.0 == M_PI
                    break;
                case UIInterfaceOrientationPortrait:
                    angle = (CGFloat)(M_PI*-90.0)/180.0;
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                    angle = (CGFloat)(M_PI*90.0)/180.0;
                    break;
                default:
                    return;
            }
            break;
        }
    }

    CGAffineTransform rotation = CGAffineTransformMakeRotation( angle );

    [UIView beginAnimations: @"" context: NULL];
    [UIView setAnimationDuration: 0.4];
    self.view.transform = CGAffineTransformConcat(self.view.transform, rotation);
    [UIView commitAnimations];
}

- (void) orientationDidChange:(NSNotification *)note
{
    UIInterfaceOrientation orientation = [[[note userInfo] objectForKey: UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    if ( [self shouldAutorotateToInterfaceOrientation: [[UIApplication sharedApplication] statusBarOrientation]] == NO )
        return;

    self.view.frame = [[UIScreen mainScreen] applicationFrame];

    [self didRotateFromInterfaceOrientation: orientation];
}


@end
