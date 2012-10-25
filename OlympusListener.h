#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>

@interface OlympusListener : NSObject <LAListener>
{
	UIWindow *_topWindow;
}

//- (id)shareSheetWithItems:(NSArray *)items;

@end
