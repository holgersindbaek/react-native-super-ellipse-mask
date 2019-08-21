#import <UIKit/UIKit.h>

@class RCTEventDispatcher;

@interface SuperEllipseMask : UIView

@property (nonatomic, assign) CGFloat topLeft;
@property (nonatomic, assign) CGFloat topRight;
@property (nonatomic, assign) CGFloat bottomRight;
@property (nonatomic, assign) CGFloat bottomLeft;

@property (nonatomic, assign) CGFloat brdWidth;
@property (nonatomic, assign) NSNumber* brdColor;

- (instancetype)initWithFrame:(CGRect)frame
NS_DESIGNATED_INITIALIZER;

@end