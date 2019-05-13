//
//  UIView+ATExt.h
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/26.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ATExt)

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


#pragma mark - 设置辉光效果

@property (nonatomic, strong) UIColor *glowColor; ///< 辉光的颜色
@property (nonatomic, strong) NSNumber *glowOpacity; ///< 辉光的透明度
@property (nonatomic, strong) NSNumber *glowRadius; ///<  辉光的阴影半径

#pragma mark - 设置辉光时间间隔

@property (nonatomic, strong) NSNumber *glowAnimationDuration; ///< 一次完整的辉光周期（从显示到透明或者从透明到显示），默认1s
@property (nonatomic, strong) NSNumber *glowDuration; ///< 保持辉光时间（不设置，默认为0.5s）
@property (nonatomic, strong) NSNumber *hideDuration; ///< 不显示辉光的周期（不设置默认为0.5s）

#pragma mark - 辉光相关操作

- (void)createGlowLayer; ///< 创建出辉光layer
- (void)insertGlowLayer; ///< 插入辉光的layer
- (void)removeGlowLayer; ///< 移除辉光的layer
- (void)glowToshowAnimated:(BOOL)animated; ///< 显示辉光
- (void)glowToHideAnimated:(BOOL)animated; ///< 隐藏辉光
- (void)startGlowLoop; ///< 开始循环辉光


@end

NS_ASSUME_NONNULL_END
