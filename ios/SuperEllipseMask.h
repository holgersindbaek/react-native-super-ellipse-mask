#import <UIKit/UIKit.h>

@class RCTEventDispatcher;

@interface SuperEllipseMask : UIView

@property (nonatomic, assign) CGFloat brdRadius;
@property (nonatomic, assign) CGFloat brdWidth;
@property (nonatomic, assign) NSNumber* brdColor;
@property (nonatomic, assign) NSNumber* bckColor;


- (instancetype)initWithFrame:(CGRect)frame
NS_DESIGNATED_INITIALIZER;

@end
