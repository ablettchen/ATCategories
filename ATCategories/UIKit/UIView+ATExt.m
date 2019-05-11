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
- (CGFloat)safeAreaBottomGap
{
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

- (CGFloat)safeAreaTopGap
{
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

- (CGFloat)safeAreaLeftGap
{
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

- (CGFloat)safeAreaRightGap
{
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

@end
