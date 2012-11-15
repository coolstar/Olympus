#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>

#import "Classes/OLWifiToggle.h"
#import "Classes/OLAirplaneModeToggle.h"
#import "Classes/OLBTToggle.h"
#import "Classes/OLPowerButton.h"
#import "Classes/OLCellularToggle.h"
#import "Classes/OLBrightnessSlider.h"

@interface OlympusListener : NSObject <LAListener>
{
	UIWindow *_topWindow;

	//toggles
	OLWiFiToggle *_wiFiToggle;
	OLAirplaneModeToggle *_airplaneToggle;
	OLBTToggle *_bluetoothToggle;
	OLCellularToggle *_cellularToggle;

	OLPowerButton *_powerButton;
	OLBrightnessSlider *_brightnessSlider;
}

@end
