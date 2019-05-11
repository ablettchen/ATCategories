//
//  NSData+ATExt.h
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/26.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ATExt)

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)jsonValueDecoded;

/**
 Returns string decoded in UTF8.
 */
- (nullable NSString *)utf8String;

@end

NS_ASSUME_NONNULL_END
