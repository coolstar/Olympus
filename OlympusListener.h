#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>

#import "OLWifiToggle.h"

@interface OlympusListener : NSObject <LAListener>
{
	UIWindow *_topWindow;
	OLWiFiToggle *_wiFiToggle;
}

//- (id)shareSheetWithItems:(NSArray *)items;

@end
