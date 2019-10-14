//
//  UIViewController+ATExt.h
//  ATCategories
//
//  Created by ablett on 2019/10/14.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ATExt)

- (void)at_setInterfaceOrientationToPreferred;
- (void)at_setInterfaceOrientationToPortrait;
- (void)at_changeInterfaceOrientation:(enum UIInterfaceOrientation)interfaceOrientation;

@end

NS_ASSUME_NONNULL_END
