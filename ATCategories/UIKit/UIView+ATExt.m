//
//  UIView+ATExt.m
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/26.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import "UIView+ATExt.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static void *kUIViewATExdPropertyBottomGap = &kUIViewATExdPropertyBottomGap;
static void *kUIViewATExdPropertyTopGap = &kUIViewATExdPropertyTopGap;
static void *kUIViewATExdPropertyLeftGap = &kUIViewATExdPropertyLeftGap;
static void *kUIViewATExdPropertyRightGap = &kUIViewATExdPropertyRightGap;

@interface UIView ()
@property (nonatomic, strong) CALayer *glowLayer;
@property (nonatomic, strong) dispatch_source_t dispatchSource;
@end

@implementation UIView (ATExt)

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

- (CGFloat)at_left {
    return self.frame.origin.x;
}

- (void)setAt_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)at_top {
    return self.frame.origin.y;
}

- (void)setAt_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)at_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setAt_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)at_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setAt_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)at_width {
    return self.frame.size.width;
}

- (void)setAt_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)at_height {
    return self.frame.size.height;
}

- (void)setAt_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)at_centerX {
    return self.center.x;
}

- (void)setAt_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)at_centerY {
    return self.center.y;
}

- (void)setAt_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)at_origin {
    return self.frame.origin;
}

- (void)setAt_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)at_size {
    return self.frame.size;
}

- (void)setAt_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

// iPhoneX adapt
- (CGFloat)safeAreaBottomGap {
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewATExdPropertyBottomGap);
    if (gap == nil) {
        if (@available(iOS 11, *)) {
            if (self.superview.safeAreaLayoutGuide.layoutFrame.size.height > 0) {
                gap = @((self.superview.at_height - self.superview.safeAreaLayoutGuide.layoutFrame.origin.y - self.superview.safeAreaLayoutGuide.layoutFrame.size.height));
            } else {
                gap = nil;
            }
        } else {
            gap = @(0);
        }
        objc_setAssociatedObject(self, kUIViewATExdPropertyBottomGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)safeAreaTopGap {
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewATExdPropertyTopGap);
    if (gap == nil) {
        if (@available(iOS 11, *)) {
            gap = @(self.superview.safeAreaLayoutGuide.layoutFrame.origin.y);
        } else {
            gap = @(0);
        }
        objc_setAssociatedObject(self, kUIViewATExdPropertyTopGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)safeAreaLeftGap {
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewATExdPropertyLeftGap);
    if (gap == nil) {
        if (@available(iOS 11, *)) {
            gap = @(self.superview.safeAreaLayoutGuide.layoutFrame.origin.x);
        } else {
            gap = @(0);
        }
        objc_setAssociatedObject(self, kUIViewATExdPropertyLeftGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)safeAreaRightGap {
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewATExdPropertyRightGap);
    if (gap == nil) {
        if (@available(iOS 11, *)) {
            gap = @(self.superview.safeAreaLayoutGuide.layoutFrame.origin.x);
        } else {
            gap = @(0);
        }
        objc_setAssociatedObject(self, kUIViewATExdPropertyRightGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (void)createGlowLayer {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:self.bounds];
    [[self accessGlowColor] setFill];
    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
    self.glowLayer = [CALayer layer];
    self.glowLayer.frame = self.bounds;
    self.glowLayer.contents = (__bridge id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    self.glowLayer.opacity = 0.f;
    self.glowLayer.shadowOffset = CGSizeMake(0, 0);
    self.glowLayer.shadowOpacity = 1.f;
    UIGraphicsEndImageContext();
}

- (void)insertGlowLayer {
    if (self.glowLayer) {
        [self.layer addSublayer:self.glowLayer];
    }
}

- (void)removeGlowLayer {
    if (self.glowLayer) {
        [self.glowLayer removeFromSuperlayer];
    }
}

- (void)glowToshowAnimated:(BOOL)animated {
    self.glowLayer.shadowColor = [self accessGlowColor].CGColor;
    self.glowLayer.shadowRadius = [self accessGlowRadius].floatValue;
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = @(0.f);
        animation.toValue = [self accessGlowOpacity];
        self.glowLayer.opacity = [self accessGlowOpacity].floatValue;
        animation.duration = [self accessAnimationDuration].floatValue;
        [self.glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
    } else {
        [self.glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.glowLayer.opacity = [self accessGlowOpacity].floatValue;
    }
}

- (void)glowToHideAnimated:(BOOL)animated {
    self.glowLayer.shadowColor = [self accessGlowColor].CGColor;
    self.glowLayer.shadowRadius = [self accessGlowRadius].floatValue;
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = [self accessGlowOpacity];
        animation.toValue = @(0.f);
        self.glowLayer.opacity = 0.f;
        animation.duration = [self accessAnimationDuration].floatValue;
        [self.glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
    } else {
        [self.glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.glowLayer.opacity = 0.f;
    }
}

- (void)startGlowLoop {
    if (self.dispatchSource == nil) {
        CGFloat seconds = [self accessAnimationDuration].floatValue * 2 + [self accessGlowDuration].floatValue + [self accessHideDuration].floatValue;
        CGFloat delaySeconds = [self accessAnimationDuration].floatValue + [self accessGlowDuration].floatValue;
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        __weak UIView *weakSelf = self;
        dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), NSEC_PER_SEC * seconds, 0);
        dispatch_source_set_event_handler(self.dispatchSource, ^{
            [weakSelf glowToshowAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delaySeconds), dispatch_get_main_queue(), ^{
                [weakSelf glowToHideAnimated:YES];
            });
        });
        dispatch_resume(self.dispatchSource);
    }
}

#pragma mark - 处理数据越界问题

- (NSNumber *)accessGlowOpacity {
    if (self.glowOpacity) {
        if (self.glowOpacity.floatValue <= 0 || self.glowOpacity.floatValue > 1) {
            return @(0.8);
        } else {
            return self.glowOpacity;
        }
    }else {
        return @(0.8);
    }
}

- (NSNumber *)accessGlowDuration {
    if (self.glowDuration) {
        if (self.glowDuration.floatValue <= 0) {
            return @(0.5f);
        } else {
            return self.glowDuration;
        }
    } else {
        return @(0.5f);
    }
}

- (NSNumber *)accessHideDuration {
    if (self.hideDuration) {
        if (self.hideDuration.floatValue < 0) {
            return @(0.5);
        } else {
            return self.hideDuration;
        }
    } else {
        return @(0.5f);
    }
}

- (NSNumber *)accessAnimationDuration {
    if (self.glowAnimationDuration) {
        if (self.glowAnimationDuration.floatValue <= 0) {
            return @(1.f);
        } else {
            return self.glowAnimationDuration;
        }
    } else {
        return @(1.f);
    }
}

- (UIColor *)accessGlowColor {
    if (self.glowColor) {
        return self.glowColor;
    }else {
        return [UIColor redColor];
    }
}

- (NSNumber *)accessGlowRadius {
    if (self.glowRadius) {
        if (self.glowRadius.floatValue <= 0) {
            return @(2.f);
        }else {
            return self.glowRadius;
        }
    } else {
        return @(2.f);
    }
}

#pragma mark - runtime属性

- (void)setDispatchSource:(dispatch_source_t)dispatchSource {
    objc_setAssociatedObject(self, @selector(dispatchSource), dispatchSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)dispatchSource {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowColor:(UIColor *)glowColor {
    objc_setAssociatedObject(self, @selector(glowColor), glowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)glowColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowOpacity:(NSNumber *)glowOpacity {
    objc_setAssociatedObject(self, @selector(glowOpacity), glowOpacity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowOpacity {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowRadius:(NSNumber *)glowRadius {
    objc_setAssociatedObject(self, @selector(glowRadius), glowRadius, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowRadius {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowAnimationDuration:(NSNumber *)glowAnimationDuration {
    objc_setAssociatedObject(self, @selector(glowAnimationDuration), glowAnimationDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowAnimationDuration {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowDuration:(NSNumber *)glowDuration {
    objc_setAssociatedObject(self, @selector(glowDuration), glowDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)glowDuration {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHideDuration:(NSNumber *)hideDuration {
    objc_setAssociatedObject(self, @selector(hideDuration), hideDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)hideDuration {
    return objc_getAssociatedObject(self, _cmd);
}

NSString * const _recognizerGlowLayer = @"_recognizerGlowLayer";

- (void)setGlowLayer:(CALayer *)glowLayer {
    objc_setAssociatedObject(self, @selector(glowLayer), glowLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)glowLayer {
    return objc_getAssociatedObject(self, _cmd);
}


@end
