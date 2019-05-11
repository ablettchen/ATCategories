//
//  UIColor+ATExt.h
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ATExt)

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

+ (nullable UIColor *)colorWithHexString:(NSString *)hexStr;
- (nullable NSString *)hexString;
- (nullable NSString *)hexStringWithAlpha;

/**
 The color's alpha component value.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat alpha;

@end

NS_ASSUME_NONNULL_END
