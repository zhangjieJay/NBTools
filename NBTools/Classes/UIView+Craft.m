//
//  UIView+Craft.m
//  Pods
//
//  Created by 张杰 on 2019/1/9.
//

#import "UIView+Craft.h"
#import <objc/runtime.h>

static NSString * const kCornerPosition = @"kCornerPosition";
static NSString * const kCornerRadius = @"kCornerRadius";
static NSString * const kBorderColor = @"kBorderWidth";
static NSString * const kBorderWidth = @"kBorderWidth";
static NSString * const kBorderAdd = @"kBorderAdd";
static NSString * const kBorderLayer = @"kBorderLayer";

static NSString * const kShowback = @"kShowback_key";
static NSString * const kGradientPosition = @"kgradientPosition";
static NSString * const kGradientLayer = @"kGradientLayer";
static NSString * const kFromColor = @"kFromColor_key";
static NSString * const kToColor = @"kToColor_key";


@implementation UIView (Craft)

@dynamic nb_cornerPosition;
@dynamic nb_cornerRadius;
@dynamic nb_borderColor;
@dynamic nb_borderWidth;
@dynamic nb_added;
@dynamic nb_borderLayer;

@dynamic showGradientBackGround;
@dynamic nb_gradientLayer;
@dynamic nb_gradientPosition;
@dynamic nb_fromColor;
@dynamic nb_toColor;


-(NBCornerPosition)nb_cornerPosition{
    return [objc_getAssociatedObject(self, &kCornerPosition) integerValue];
}
-(void)setNb_cornerPosition:(NBCornerPosition)nb_cornerPosition{
    objc_setAssociatedObject(self, &kCornerPosition, @(nb_cornerPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)nb_cornerRadius{
    return [objc_getAssociatedObject(self, &kCornerRadius) floatValue];
}
- (void)setNb_cornerRadius:(CGFloat)nb_cornerRadius{
    objc_setAssociatedObject(self, &kCornerRadius, @(nb_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



-(UIColor *)nb_borderColor{
    return objc_getAssociatedObject(self, &kBorderColor);
}
-(void)setNb_borderColor:(UIColor *)nb_borderColor{
    objc_setAssociatedObject(self, &kBorderColor, nb_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)nb_borderWidth{
    return [objc_getAssociatedObject(self, &kBorderWidth) floatValue];
}
- (void)setNb_borderWidth:(CGFloat)nb_borderWidth{
    objc_setAssociatedObject(self, &kBorderWidth, @(nb_borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)nb_added{
    return [objc_getAssociatedObject(self, &kBorderAdd) boolValue];
}

-(void)setNb_added:(BOOL)nb_added{
    objc_setAssociatedObject(self, &kBorderAdd, @(nb_added), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CAShapeLayer *)nb_borderLayer{
    return objc_getAssociatedObject(self, &kBorderLayer);
}
-(void)setNb_borderLayer:(CAShapeLayer *)nb_borderLayer{
    objc_setAssociatedObject(self, &kBorderLayer, nb_borderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)showGradientBackGround{
    return [objc_getAssociatedObject(self, &kShowback) boolValue];
}
- (void)setShowGradientBackGround:(BOOL)showGradientBackGround{
    objc_setAssociatedObject(self, &kShowback, @(showGradientBackGround), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CAGradientLayer *)nb_gradientLayer{
    return objc_getAssociatedObject(self, &kGradientLayer);
}
-(void)setNb_gradientLayer:(CAGradientLayer *)nb_gradientLayer{
    objc_setAssociatedObject(self, &kGradientLayer, nb_gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NBGradientPosition)nb_gradientPosition{
    return [objc_getAssociatedObject(self, &kGradientPosition) integerValue];
}
-(void)setNb_gradientPosition:(NBGradientPosition)nb_gradientPosition{
    objc_setAssociatedObject(self, &kGradientPosition, @(nb_gradientPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)nb_fromColor{
    return objc_getAssociatedObject(self, &kFromColor);
}
-(void)setNb_fromColor:(UIColor *)nb_fromColor{
    objc_setAssociatedObject(self, &kFromColor, nb_fromColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIColor *)nb_toColor{
    return objc_getAssociatedObject(self, &kToColor);
}
-(void)setNb_toColor:(UIColor *)nb_toColor{
    objc_setAssociatedObject(self, &kToColor, nb_toColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



+(void)load{
    SEL originalSel = @selector(layoutSublayersOfLayer:);
    SEL swizzleSel = NSSelectorFromString([@"nb_" stringByAppendingString:NSStringFromSelector(originalSel)]);
    nb_swizzle(self, originalSel, swizzleSel);
}

void nb_swizzle(Class class,SEL ori,SEL swi){
    Method origMethod = class_getInstanceMethod(class, ori);
    Method newMethod = class_getInstanceMethod(class, swi);
    method_exchangeImplementations(origMethod, newMethod);
}

-(void)nb_layoutSublayersOfLayer:(CALayer *)layer{
    
    [self nb_layoutSublayersOfLayer:layer];
    
    if (self.nb_cornerRadius > 0) {
        UIGraphicsBeginImageContext(self.bounds.size);
        
        UIBezierPath *maskPath;
        switch (self.nb_cornerPosition) {
                case NBCornerPosition_Top:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_Left:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_Bottom:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_Right:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_All:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerAllCorners
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_AllRound:{
                    CGFloat ratio = MIN(self.bounds.size.width,self.bounds.size.height);
                    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(ratio/2.f, ratio/2.f)];
                    break;
                }
                case NBCornerPosition_LB_RT:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_LT_RB:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopLeft
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_LB:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerBottomLeft
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_LT:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerTopLeft
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_RT:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerTopRight
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
                case NBCornerPosition_RB:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerBottomRight
                                                       cornerRadii:CGSizeMake(self.nb_cornerRadius, self.nb_cornerRadius)];
                break;
            default:
                break;
        }
        if (maskPath) {//代表需要进行
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.frame = self.bounds;
            maskLayer.path = maskPath.CGPath;
            self.layer.mask = maskLayer;
            
            if (self.nb_borderWidth >0 && self.nb_borderColor) {//需要border处理
                if (self.nb_added) {//已经添加了
                    self.nb_borderLayer.fillColor  = [UIColor clearColor].CGColor;
                    self.nb_borderLayer.strokeColor    = self.nb_borderColor.CGColor;
                    self.nb_borderLayer.lineWidth      = self.nb_borderWidth;
                    self.nb_borderLayer.path    =   maskPath.CGPath;
                    self.nb_borderLayer.frame = self.bounds;
                }
                else{
                    
                    self.nb_added = YES;
                    CAShapeLayer *borderLayer = [CAShapeLayer layer];
                    borderLayer.path    =   maskPath.CGPath;
                    borderLayer.fillColor  = [UIColor clearColor].CGColor;
                    borderLayer.strokeColor    = self.nb_borderColor.CGColor;
                    borderLayer.lineWidth      = self.nb_borderWidth;
                    borderLayer.frame = self.bounds;
                    self.nb_borderLayer = borderLayer;
                    [self.layer addSublayer:borderLayer];
                }
            }
            else{//不需要则移除
                if (self.nb_borderColor) {
                    self.nb_added = NO;
                    [self.nb_borderLayer removeFromSuperlayer];
                }
            }
        }
        UIGraphicsEndImageContext();
    }
    if (self.showGradientBackGround) {
        UIGraphicsBeginImageContext(self.bounds.size);
        
        
        
        if (!self.nb_gradientLayer) {
            self.nb_gradientLayer = [CAGradientLayer layer];
            self.nb_gradientLayer.frame = self.bounds;
            [self.layer insertSublayer:self.nb_gradientLayer atIndex:0];
        }
        self.nb_gradientLayer.frame = self.bounds;
        if (!self.nb_fromColor) {
            self.nb_fromColor = [UIColor redColor];
        }
        if (!self.nb_toColor) {
            self.nb_toColor = [UIColor blueColor];
        }
        
        //  创建渐变色数组，需要转换为CGColor颜色
        self.nb_gradientLayer.colors = @[(__bridge id)self.nb_fromColor.CGColor,(__bridge id)self.nb_toColor.CGColor];
        //设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        if (self.nb_gradientPosition == NBGradientPosition_TopToBottom) {
            self.nb_gradientLayer.startPoint = CGPointMake(0, 0);
            self.nb_gradientLayer.endPoint = CGPointMake(0, 1);
        }
        else if (self.nb_gradientPosition == NBGradientPosition_RightToLeft) {
            self.nb_gradientLayer.startPoint = CGPointMake(0, 0);
            self.nb_gradientLayer.endPoint = CGPointMake(1, 0);
        }
        //设置颜色变化点，取值范围 0.0~1.0
        self.nb_gradientLayer.locations = @[@0,@1];
        UIGraphicsEndImageContext();
        
    }else{
        if (self.nb_gradientLayer) {
            [self.nb_gradientLayer removeFromSuperlayer];
            self.nb_gradientLayer = nil;
        }
    }
}

- (void)nb_setTopCornerRadius:(CGFloat)radius
{
    self.nb_cornerPosition = NBCornerPosition_Top;
    self.nb_cornerRadius = radius;
}

- (void)nb_setLeftCornerRadius:(CGFloat)radius
{
    self.nb_cornerPosition = NBCornerPosition_Left;
    self.nb_cornerRadius = radius;
}

- (void)nb_setBottomCornerRadius:(CGFloat)radius
{
    self.nb_cornerPosition = NBCornerPosition_Bottom;
    self.nb_cornerRadius = radius;
}

- (void)nb_setRightCornerRadius:(CGFloat)radius
{
    self.nb_cornerPosition = NBCornerPosition_Right;
    self.nb_cornerRadius = radius;
}

- (void)nb_setAllCornerRadius:(CGFloat)radius
{
    self.nb_cornerPosition = NBCornerPosition_All;
    self.nb_cornerRadius = radius;
}
- (void)nb_setAllCornerRound{
    self.nb_cornerPosition = NBCornerPosition_AllRound;
    self.nb_borderWidth = 0.5;
    self.nb_cornerRadius = 1;
}

- (void)nb_setNoneCorner{
    self.layer.mask = nil;
}
- (void)nb_setLTRBCornerRadius:(CGFloat)radius{
    self.nb_cornerPosition = NBCornerPosition_LT_RB;
    self.nb_cornerRadius = radius;
}
- (void)nb_setLBRTCornerRadius:(CGFloat)radius{
    self.nb_cornerPosition = NBCornerPosition_LB_RT;
    self.nb_cornerRadius = radius;
}
- (void)nb_setLelfTopCornerRadius:(CGFloat)radius{
    self.nb_cornerPosition = NBCornerPosition_LT;
    self.nb_cornerRadius = radius;
}
- (void)nb_setLelfBottompCornerRadius:(CGFloat)radius{
    self.nb_cornerPosition = NBCornerPosition_LB;
    self.nb_cornerRadius = radius;
}
- (void)nb_setRightBottompCornerRadius:(CGFloat)radius{
    self.nb_cornerPosition = NBCornerPosition_RB;
    self.nb_cornerRadius = radius;
}
- (void)nb_setRightToppCornerRadius:(CGFloat)radius{
    self.nb_cornerPosition = NBCornerPosition_RT;
    self.nb_cornerRadius = radius;
}

@end
