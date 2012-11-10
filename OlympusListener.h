#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>

#import "Classes/OLSocialActivity.h"
#import "Classes/OLWifiToggle.h"
#import "Classes/OLAirplaneModeToggle.h"
#import "Classes/OLBTToggle.h"
#import "Classes/OLPowerButton.h"

@interface OlympusListener : NSObject <LAListener>
{
	UIWindow *_topWindow;

	//toggles
	OLWiFiToggle *_wiFiToggle;
	OLAirplaneModeToggle *_airplaneToggle;
	OLBTToggle *_bluetoothToggle;

	OLPowerButton *_powerButton;

	//activities by other developers
	//NSArray *_thirdPartyActivities;
}

@end
