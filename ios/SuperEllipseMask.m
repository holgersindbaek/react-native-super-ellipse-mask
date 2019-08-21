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
    CAShapeLayer *maskLayer;
    CAShapeLayer *borderLayer;
    UIView *maskView;
    CGFloat internalBrdWidth;
    UIColor *internalBrdColor;

    CGFloat coeff;
    NSArray *values;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        coeff = 1.28195;

        internalBrdWidth = [UIScreen mainScreen].scale;
        internalBrdColor = [UIColor clearColor];

        maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.contentsScale = [UIScreen mainScreen].scale;
        maskLayer.shouldRasterize = YES;
        maskLayer.rasterizationScale = [UIScreen mainScreen].scale * 2;
        maskLayer.frame = frame;
        maskLayer.fillColor = [UIColor blackColor].CGColor;
        self.layer.opaque = NO;

        borderLayer = [[CAShapeLayer alloc] init];
        borderLayer.contentsScale = [UIScreen mainScreen].scale;
        borderLayer.shouldRasterize = YES;
        borderLayer.rasterizationScale = [UIScreen mainScreen].scale * 2;
        borderLayer.frame = frame;
        borderLayer.opaque = false;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = internalBrdColor.CGColor;
        borderLayer.lineWidth = internalBrdWidth;
        [self.layer addSublayer:borderLayer];

        // set mask layer
        maskView = [[UIView alloc] init];
        [maskView.layer addSublayer:maskLayer];
        self.maskView = maskView;

        self.topRight = 0;
        self.bottomRight = 0;
        self.topLeft = 0;
        self.bottomLeft = 0;
    }

    return self;
}

- (void)setBounds:(CGRect)newBounds {
    [super setBounds:newBounds];

    borderLayer.frame = newBounds;
    maskLayer.frame = newBounds;
    maskView.frame = newBounds;

    [self drawRect:newBounds];
}

- (void)setFrame:(CGRect)newFrame {
    [super setFrame:newFrame];

    borderLayer.frame = newFrame;
    maskLayer.frame = newFrame;
    maskView.frame = newFrame;

    [self drawRect:newFrame];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    [self cornerLogic:rect];

    UIBezierPath *path = [self drawPath:rect];

    maskLayer.path = path.CGPath;
    borderLayer.path = path.CGPath;
    borderLayer.strokeColor = internalBrdColor.CGColor;
    borderLayer.lineWidth = internalBrdWidth;
}

- (UIBezierPath *)drawPath:(CGRect)rect {
  UIBezierPath *path = [[UIBezierPath alloc] init];

  CGPoint last = CGPointMake(rect.size.width, rect.origin.y);
  // edit path
  [path moveToPoint:CGPointMake(rect.origin.x + self.topLeft * coeff, last.y)];

  // top
  [path addLineToPoint:CGPointMake(last.x - self.topRight * coeff, last.y)];

  last = CGPointMake(last.x - self.topRight * coeff, last.y);
  // top right c1
  [path addCurveToPoint:CGPointMake(last.x + self.topRight * 0.77037, last.y + self.topRight * 0.13357)
          controlPoint1:CGPointMake(last.x + self.topRight * 0.44576, last.y)
          controlPoint2:CGPointMake(last.x + self.topRight * 0.6074, last.y + self.topRight * 0.04641)];
  // top right c2
  last = CGPointMake(last.x + self.topRight * 0.77037, last.y + self.topRight * 0.13357);
  [path addCurveToPoint:CGPointMake(last.x + self.topRight * 0.37801, last.y + self.topRight * 0.37801)
          controlPoint1:CGPointMake(last.x + self.topRight * 0.16296, last.y + self.topRight * 0.08715)
          controlPoint2:CGPointMake(last.x + self.topRight * 0.290086, last.y + self.topRight * 0.2150)];
  // top right c3
  last = CGPointMake(last.x + self.topRight * 0.37801, last.y + self.topRight * 0.37801);
  [path addCurveToPoint:CGPointMake(last.x + self.topRight * 0.13357, last.y + self.topRight * 0.77037)
          controlPoint1:CGPointMake(last.x + self.topRight * 0.08715, last.y + self.topRight * 0.16296)
          controlPoint2:CGPointMake(last.x + self.topRight * 0.13357, last.y + self.topRight * 0.32461)];

  last = CGPointMake(rect.size.width, rect.size.height);
  // right
  [path addLineToPoint:CGPointMake(last.x, last.y - self.bottomRight * coeff)];

  last = CGPointMake(last.x, last.y - self.bottomRight * coeff);
  // bottom right c1
  [path addCurveToPoint:CGPointMake(last.x - self.bottomRight * 0.13357, last.y + self.bottomRight * 0.77037)
          controlPoint1:CGPointMake(last.x, last.y + self.bottomRight * 0.44576)
          controlPoint2:CGPointMake(last.x - self.bottomRight * 0.04641, last.y + self.bottomRight * 0.6074)];
  // bottom right c2
  last = CGPointMake(last.x - self.bottomRight * 0.13357, last.y + self.bottomRight * 0.77037);
  [path addCurveToPoint:CGPointMake(last.x - self.bottomRight * 0.37801, last.y + self.bottomRight * 0.37801)
          controlPoint1:CGPointMake(last.x - self.bottomRight * 0.08715, last.y + self.bottomRight * 0.16296)
          controlPoint2:CGPointMake(last.x - self.bottomRight * 0.21505, last.y + self.bottomRight * 0.290086)];
  // bottom right c3
  last = CGPointMake(last.x - self.bottomRight * 0.37801, last.y + self.bottomRight * 0.37801);
  [path addCurveToPoint:CGPointMake(last.x - self.bottomRight * 0.77037, last.y + self.bottomRight * 0.13357)
          controlPoint1:CGPointMake(last.x - self.bottomRight * 0.16296, last.y + self.bottomRight * 0.08715)
          controlPoint2:CGPointMake(last.x - self.bottomRight * 0.32461, last.y + self.bottomRight * 0.13357)];

  last = CGPointMake(rect.origin.x, rect.size.height);
  // bottom
  [path addLineToPoint:CGPointMake(last.x + self.bottomLeft * coeff, last.y)];

  last = CGPointMake(last.x + self.bottomLeft * coeff, last.y);
  // bottom left c1
  [path addCurveToPoint:CGPointMake(last.x - self.bottomLeft * 0.77037, last.y - self.bottomLeft * 0.13357)
          controlPoint1:CGPointMake(last.x - self.bottomLeft * 0.44576, last.y)
          controlPoint2:CGPointMake(last.x - self.bottomLeft * 0.6074, last.y - self.bottomLeft * 0.04641)];
  // bottom left c2
  last = CGPointMake(last.x - self.bottomLeft * 0.77037, last.y - self.bottomLeft * 0.13357);
  [path addCurveToPoint:CGPointMake(last.x - self.bottomLeft * 0.37801, last.y - self.bottomLeft * 0.37801)
          controlPoint1:CGPointMake(last.x - self.bottomLeft * 0.16296, last.y - self.bottomLeft * 0.08715)
          controlPoint2:CGPointMake(last.x - self.bottomLeft * 0.290086, last.y - self.bottomLeft * 0.2150)];
  // bottom left c3
  last = CGPointMake(last.x - self.bottomLeft * 0.37801, last.y - self.bottomLeft * 0.37801);
  [path addCurveToPoint:CGPointMake(last.x - self.bottomLeft * 0.13357, last.y - self.bottomLeft * 0.77037)
          controlPoint1:CGPointMake(last.x - self.bottomLeft * 0.08715, last.y - self.bottomLeft * 0.16296)
          controlPoint2:CGPointMake(last.x - self.bottomLeft * 0.13357, last.y - self.bottomLeft * 0.32461)];

  // left
  [path addLineToPoint:CGPointMake(rect.origin.x, rect.origin.y + self.topLeft * coeff)];

  last = CGPointMake(rect.origin.x, rect.origin.y + self.topLeft * coeff);
  // top left c1
  [path addCurveToPoint:CGPointMake(last.x + self.topLeft * 0.13357, last.y - self.topLeft * 0.77037)
          controlPoint1:CGPointMake(last.x, last.y - self.topLeft * 0.44576)
          controlPoint2:CGPointMake(last.x + self.topLeft * 0.04641, last.y - self.topLeft * 0.6074)];
  // top left c2
  last = CGPointMake(last.x + self.topLeft * 0.13357, last.y - self.topLeft * 0.77037);
  [path addCurveToPoint:CGPointMake(last.x + self.topLeft * 0.37801, last.y - self.topLeft * 0.37801)
          controlPoint1:CGPointMake(last.x + self.topLeft * 0.08715, last.y - self.topLeft * 0.16296)
          controlPoint2:CGPointMake(last.x + self.topLeft * 0.21505, last.y - self.topLeft * 0.290086)];
  // top left c3
  last = CGPointMake(last.x + self.topLeft * 0.37801, last.y - self.topLeft * 0.37801);
  [path addCurveToPoint:CGPointMake(last.x + self.topLeft * 0.77037, last.y - self.topLeft * 0.13357)
          controlPoint1:CGPointMake(last.x + self.topLeft * 0.16296, last.y - self.topLeft * 0.08715)
          controlPoint2:CGPointMake(last.x + self.topLeft * 0.32461, last.y - self.topLeft * 0.13357)];


  [path closePath];

  return path;
}

- (void)cornerLogic:(CGRect)rect {
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;

    CGFloat mTopLeft = self.topLeft * coeff;
    CGFloat mTopRight = self.topRight * coeff;
    CGFloat mBottomRight = self.bottomRight * coeff;
    CGFloat mBottomLeft = self.bottomLeft * coeff;

    CGFloat shorter;
    CGFloat x;

    // topRight
    shorter = MIN(w, h);
    x = mTopRight;
    x = x > shorter ? shorter : x;
    self.topRight = x / coeff;

    // bottomRight
    shorter = MIN(w, h - x);
    x = mBottomRight;
    x = x > shorter ? shorter : x;
    self.bottomRight = x / coeff;

    // bottomLeft
    shorter = MIN(w - x, h);
    x = mBottomLeft;
    x = x > shorter ? shorter : x;
    self.bottomLeft = x / coeff;

    // topLeft
    shorter = MIN(w - self.topRight * coeff, h - x);
    x = mTopLeft;
    x = x > shorter ? shorter : x;
    self.topLeft = x / coeff;
}

- (void)setBrdColor:(NSNumber *)color {
  internalBrdColor = [RCTConvert UIColor:color];
}

- (void)setBrdWidth:(CGFloat)width {
  internalBrdWidth = width * [UIScreen mainScreen].scale;
}

@end
