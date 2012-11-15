#import "OLBrightnessSlider.h"
@implementation OLBrightnessSlider

- (NSString *)activityType
{
	return @"OLBrightnessSlider";
}

- (NSString *)activityTitle
{
	return @"Brightness";
}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:@"olympus_brightness.png"];
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
	UIAlertView *alert = [[UIAlertView alloc]
					initWithTitle:@"Brightness"
                    message:@" "
                    delegate:self
                    cancelButtonTitle:@"Dismiss"
                    otherButtonTitles:nil];

    UISlider *brightnessSlider = [[UISlider alloc] initWithFrame:CGRectMake(15, 50, 250, 20)];
   	brightnessSlider.value = [[UIScreen mainScreen] brightness];
   	[brightnessSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [alert addSubview:brightnessSlider];            
    [alert show];
    [alert release];
}

- (void)sliderValueChanged:(UISlider *)slider
{
	[[UIScreen mainScreen] setBrightness:slider.value];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[[[alert subviews] lastObject] release];
	return;
}

@end
