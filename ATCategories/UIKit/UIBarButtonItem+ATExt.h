//
//  UIBarButtonItem+ATExt.h
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/26.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (ATExt)

/**
 The block that invoked when the item is selected. The objects captured by block
 will retained by the ButtonItem.
 
 @discussion This param is conflict with `target` and `action` property.
 Set this will set `target` and `action` property to some internal objects.
 */
@property (nullable, nonatomic, copy) void (^actionBlock)(id);

@end

NS_ASSUME_NONNULL_END
