//
//  UIViewController+ATExt.h
//  ATCategories
//
//  Created by ablett on 2019/10/14.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ATExt)

- (void)at_setInterfaceOrientation:(enum UIInterfaceOrientation)interfaceOrientation;

- (UIViewController * _Nonnull)at_topViewController;

@end

NS_ASSUME_NONNULL_END
