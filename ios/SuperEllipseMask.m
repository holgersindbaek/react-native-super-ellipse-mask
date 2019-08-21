#import <Foundation/Foundation.h>
#import "SuperEllipseMask.h"

#if __has_include(<React/RCTEventDispatcher.h>)
#import <React/RCTEventDispatcher.h>
#import <React/RCTConvert.h>
#elif __has_include(<RCTEventDispatcher.h>)
#import “RCTEventDispatcher.h”
#import "RCTConvert.h"
#else
#import "React/RCTEventDispatcher.h"
#import "React/RCTConvert.h"
#endif


@implementation SuperEllipseMask : UIView  {

    RCTEventDispatcher *_eventDispatcher;
    CAShapeLayer *mask;
    UIBezierPath *path;
    UIView *containerView;
    UIView *borderView;
    CGFloat internalBrdWidth;
    UIColor *internalBrdColor;
    UIColor *internalBckColor;

    CGFloat coeff;
    NSArray *values;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    coeff = 1.28195;

    internalBrdWidth = [UIScreen mainScreen].scale;
    internalBrdColor = [UIColor clearColor];
    internalBckColor = [UIColor clearColor];

    mask = [[CAShapeLayer alloc] init];
    mask.frame = frame;
    path = [[UIBezierPath alloc] init];
    mask.fillColor = [UIColor blackColor].CGColor;
    self.layer.opaque = false;

    containerView = [[UIView alloc] init];
    containerView.frame = frame;
    [self addSubview:containerView];

    borderView = [[UIView alloc] init];
    borderView.frame = frame;
    [self addSubview:borderView];
  }

  return self;
}

- (void)didAddSubview:(UIView *)subview {
  if (subview != borderView && subview != containerView) {
    UIView *newSubview = subview;
    [subview removeFromSuperview];
    [containerView addSubview:newSubview];
  }
}

- (void)setBounds:(CGRect)newBounds {
  [super setBounds:newBounds];

  mask.frame = newBounds;
  containerView.frame = newBounds;
  borderView.frame = newBounds;

  [self drawRect:newBounds];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];

  [self cornerLogic:rect];

  [self drawPath:rect];

  self.backgroundColor = [UIColor clearColor];
  self.layer.backgroundColor = [UIColor clearColor].CGColor;
  self.opaque = false;
  self.layer.opaque = false;

  CAShapeLayer *maskShape = [[CAShapeLayer alloc] init];
  maskShape.contentsScale = [UIScreen mainScreen].scale;
  maskShape.shouldRasterize = YES;
  maskShape.rasterizationScale = [UIScreen mainScreen].scale * 2;
  maskShape.path = path.CGPath;

  containerView.frame = rect;

  borderView.frame = rect;
  CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
  borderLayer.contentsScale = [UIScreen mainScreen].scale;
  borderLayer.shouldRasterize = YES;
  borderLayer.rasterizationScale = [UIScreen mainScreen].scale * 2;
  borderLayer.path = path.CGPath;
  borderLayer.opaque = false;
  borderLayer.fillColor = [UIColor clearColor].CGColor;
  borderLayer.strokeColor = internalBrdColor.CGColor;
  borderLayer.lineWidth = internalBrdWidth;
  [containerView.layer addSublayer:borderLayer];

  // Background color color
  containerView.backgroundColor = internalBckColor;

  // mask the view
  containerView.layer.mask = maskShape;
}

- (void)drawPath:(CGRect)rect {
  CGPoint last = CGPointMake(rect.size.width, rect.origin.y);
  // edit path
  [path moveToPoint:CGPointMake(rect.origin.x + self.brdRadius * coeff, last.y)];

  // top
  [path addLineToPoint:CGPointMake(last.x - self.brdRadius * coeff, last.y)];

  last = CGPointMake(last.x - self.brdRadius * coeff, last.y);
  // top right c1
  [path addCurveToPoint:CGPointMake(last.x + self.brdRadius * 0.77037, last.y + self.brdRadius * 0.13357)
          controlPoint1:CGPointMake(last.x + self.brdRadius * 0.44576, last.y)
          controlPoint2:CGPointMake(last.x + self.brdRadius * 0.6074, last.y + self.brdRadius * 0.04641)];
  // top right c2
  last = CGPointMake(last.x + self.brdRadius * 0.77037, last.y + self.brdRadius * 0.13357);
  [path addCurveToPoint:CGPointMake(last.x + self.brdRadius * 0.37801, last.y + self.brdRadius * 0.37801)
          controlPoint1:CGPointMake(last.x + self.brdRadius * 0.16296, last.y + self.brdRadius * 0.08715)
          controlPoint2:CGPointMake(last.x + self.brdRadius * 0.290086, last.y + self.brdRadius * 0.2150)];
  // top right c3
  last = CGPointMake(last.x + self.brdRadius * 0.37801, last.y + self.brdRadius * 0.37801);
  [path addCurveToPoint:CGPointMake(last.x + self.brdRadius * 0.13357, last.y + self.brdRadius * 0.77037)
          controlPoint1:CGPointMake(last.x + self.brdRadius * 0.08715, last.y + self.brdRadius * 0.16296)
          controlPoint2:CGPointMake(last.x + self.brdRadius * 0.13357, last.y + self.brdRadius * 0.32461)];

  last = CGPointMake(rect.size.width, rect.size.height);
  // right
  [path addLineToPoint:CGPointMake(last.x, last.y - self.brdRadius * coeff)];

  last = CGPointMake(last.x, last.y - self.brdRadius * coeff);
  // bottom right c1
  [path addCurveToPoint:CGPointMake(last.x - self.brdRadius * 0.13357, last.y + self.brdRadius * 0.77037)
          controlPoint1:CGPointMake(last.x, last.y + self.brdRadius * 0.44576)
          controlPoint2:CGPointMake(last.x - self.brdRadius * 0.04641, last.y + self.brdRadius * 0.6074)];
  // bottom right c2
  last = CGPointMake(last.x - self.brdRadius * 0.13357, last.y + self.brdRadius * 0.77037);
  [path addCurveToPoint:CGPointMake(last.x - self.brdRadius * 0.37801, last.y + self.brdRadius * 0.37801)
          controlPoint1:CGPointMake(last.x - self.brdRadius * 0.08715, last.y + self.brdRadius * 0.16296)
          controlPoint2:CGPointMake(last.x - self.brdRadius * 0.21505, last.y + self.brdRadius * 0.290086)];
  // bottom right c3
  last = CGPointMake(last.x - self.brdRadius * 0.37801, last.y + self.brdRadius * 0.37801);
  [path addCurveToPoint:CGPointMake(last.x - self.brdRadius * 0.77037, last.y + self.brdRadius * 0.13357)
          controlPoint1:CGPointMake(last.x - self.brdRadius * 0.16296, last.y + self.brdRadius * 0.08715)
          controlPoint2:CGPointMake(last.x - self.brdRadius * 0.32461, last.y + self.brdRadius * 0.13357)];

  last = CGPointMake(rect.origin.x, rect.size.height);
  // bottom
  [path addLineToPoint:CGPointMake(last.x + self.brdRadius * coeff, last.y)];

  last = CGPointMake(last.x + self.brdRadius * coeff, last.y);
  // bottom left c1
  [path addCurveToPoint:CGPointMake(last.x - self.brdRadius * 0.77037, last.y - self.brdRadius * 0.13357)
          controlPoint1:CGPointMake(last.x - self.brdRadius * 0.44576, last.y)
          controlPoint2:CGPointMake(last.x - self.brdRadius * 0.6074, last.y - self.brdRadius * 0.04641)];
  // bottom left c2
  last = CGPointMake(last.x - self.brdRadius * 0.77037, last.y - self.brdRadius * 0.13357);
  [path addCurveToPoint:CGPointMake(last.x - self.brdRadius * 0.37801, last.y - self.brdRadius * 0.37801)
          controlPoint1:CGPointMake(last.x - self.brdRadius * 0.16296, last.y - self.brdRadius * 0.08715)
          controlPoint2:CGPointMake(last.x - self.brdRadius * 0.290086, last.y - self.brdRadius * 0.2150)];
  // bottom left c3
  last = CGPointMake(last.x - self.brdRadius * 0.37801, last.y - self.brdRadius * 0.37801);
  [path addCurveToPoint:CGPointMake(last.x - self.brdRadius * 0.13357, last.y - self.brdRadius * 0.77037)
          controlPoint1:CGPointMake(last.x - self.brdRadius * 0.08715, last.y - self.brdRadius * 0.16296)
          controlPoint2:CGPointMake(last.x - self.brdRadius * 0.13357, last.y - self.brdRadius * 0.32461)];

  // left
  [path addLineToPoint:CGPointMake(rect.origin.x, rect.origin.y + self.brdRadius * coeff)];

  last = CGPointMake(rect.origin.x, rect.origin.y + self.brdRadius * coeff);
  // top left c1
  [path addCurveToPoint:CGPointMake(last.x + self.brdRadius * 0.13357, last.y - self.brdRadius * 0.77037)
          controlPoint1:CGPointMake(last.x, last.y - self.brdRadius * 0.44576)
          controlPoint2:CGPointMake(last.x + self.brdRadius * 0.04641, last.y - self.brdRadius * 0.6074)];
  // top left c2
  last = CGPointMake(last.x + self.brdRadius * 0.13357, last.y - self.brdRadius * 0.77037);
  [path addCurveToPoint:CGPointMake(last.x + self.brdRadius * 0.37801, last.y - self.brdRadius * 0.37801)
          controlPoint1:CGPointMake(last.x + self.brdRadius * 0.08715, last.y - self.brdRadius * 0.16296)
          controlPoint2:CGPointMake(last.x + self.brdRadius * 0.21505, last.y - self.brdRadius * 0.290086)];
  // top left c3
  last = CGPointMake(last.x + self.brdRadius * 0.37801, last.y - self.brdRadius * 0.37801);
  [path addCurveToPoint:CGPointMake(last.x + self.brdRadius * 0.77037, last.y - self.brdRadius * 0.13357)
          controlPoint1:CGPointMake(last.x + self.brdRadius * 0.16296, last.y - self.brdRadius * 0.08715)
          controlPoint2:CGPointMake(last.x + self.brdRadius * 0.32461, last.y - self.brdRadius * 0.13357)];


  [path closePath];
}

- (void)cornerLogic:(CGRect)rect {
  CGFloat w = rect.size.width;
  CGFloat h = rect.size.height;

  CGFloat mbrdRadius = self.brdRadius * coeff;

  CGFloat shorter;
  CGFloat x;

  // brdRadius
  shorter = MIN(w, h);
  x = mbrdRadius;
  x = x > shorter ? shorter : x;
  self.brdRadius = x / coeff;

  // brdRadius
  shorter = MIN(w, h - x);
  x = mbrdRadius;
  x = x > shorter ? shorter : x;
  self.brdRadius = x / coeff;

  // brdRadius
  shorter = MIN(w - x, h);
  x = mbrdRadius;
  x = x > shorter ? shorter : x;
  self.brdRadius = x / coeff;

  // brdRadius
  shorter = MIN(w - self.brdRadius * coeff, h - x);
  x = mbrdRadius;
  x = x > shorter ? shorter : x;
  self.brdRadius = x / coeff;
}

- (void)setBckColor:(NSNumber *)color {
  internalBckColor = [RCTConvert UIColor:color];
}

- (void)setBrdColor:(NSNumber *)color {
  internalBrdColor = [RCTConvert UIColor:color];
}

- (void)setBrdWidth:(CGFloat)width {
  internalBrdWidth = width * [UIScreen mainScreen].scale;
}

@end
