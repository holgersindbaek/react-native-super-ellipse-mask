#import <Foundation/Foundation.h>
#import "SuperEllipseMask.h"
#import "SuperEllipseMaskManager.h"

#if __has_include(<React/RCTBridge.h>)
#import <React/RCTBridge.h>
#elif __has_include(“RCTBridge.h”)
#import “RCTBridge.h”
#else
#import “React/RCTBridge.h”
#endif

@implementation SuperEllipseMaskManager

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (UIView *)view
{
    return [[SuperEllipseMask alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(bckColor, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(brdColor, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(brdWidth, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(brdRadius, CGFloat)

@end
