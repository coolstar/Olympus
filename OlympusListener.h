#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>

#import "Classes/OLWifiToggle.h"
#import "Classes/OLAirplaneModeToggle.h"
#import "Classes/OLBTToggle.h"

@interface OlympusListener : NSObject <LAListener>
{
	UIWindow *_topWindow;
	OLWiFiToggle *_wiFiToggle;
	OLAirplaneModeToggle *_airplaneToggle;
	OLBTToggle *_bluetoothToggle;
}

@end
