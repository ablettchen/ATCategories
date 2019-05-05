//
//  UIView+ATExd.h
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/26.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ATExd)

- (nullable UIImage *)snapshotImage;
- (void)setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;
- (void)removeAllSubviews;

@property (nullable, nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, readonly) CGFloat visibleAlpha;

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

@property (nonatomic) CGFloat at_left;
@property (nonatomic) CGFloat at_top;
@property (nonatomic) CGFloat at_right;
@property (nonatomic) CGFloat at_bottom;
@property (nonatomic) CGFloat at_width;
@property (nonatomic) CGFloat at_height;
@property (nonatomic) CGFloat at_centerX;
@property (nonatomic) CGFloat at_centerY;
@property (nonatomic) CGPoint at_origin;
@property (nonatomic) CGSize at_size;

// iPhoneX adapt
- (CGFloat)safeAreaBottomGap;
- (CGFloat)safeAreaTopGap;
- (CGFloat)safeAreaLeftGap;
- (CGFloat)safeAreaRightGap;

@end

NS_ASSUME_NONNULL_END
