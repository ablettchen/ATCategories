//
//  UIViewController+ATExt.m
//  ATCategories
//
//  Created by ablett on 2019/10/14.
//

#import "UIViewController+ATExt.h"
#import <objc/runtime.h>

@implementation UIViewController (ATExt)

- (void)at_setInterfaceOrientation:(enum UIInterfaceOrientation)interfaceOrientation {
    
    if(![[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {return;}

    enum UIInterfaceOrientation unknow = UIInterfaceOrientationUnknown;
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    [invocation setArgument:&unknow atIndex:2];
    [invocation invoke];
    [invocation setArgument:&interfaceOrientation atIndex:2];
    [invocation invoke];
}

@end

@implementation UITabBarController (ATExt)


- (BOOL)shouldAutorotate {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController shouldAutorotate];
    } else {
        return [vc shouldAutorotate];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController supportedInterfaceOrientations];
    } else {
        return [vc supportedInterfaceOrientations];
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController preferredInterfaceOrientationForPresentation];
    } else {
        return [vc preferredInterfaceOrientationForPresentation];
    }
}

@end

