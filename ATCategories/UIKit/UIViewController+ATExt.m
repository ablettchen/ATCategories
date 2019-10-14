//
//  UIViewController+ATExt.m
//  ATCategories
//
//  Created by ablett on 2019/10/14.
//

#import "UIViewController+ATExt.h"

@implementation UIViewController (ATExt)

- (void)at_setInterfaceOrientationToPreferred {
    [self at_changeInterfaceOrientation:self.preferredInterfaceOrientationForPresentation];
}

- (void)at_setInterfaceOrientationToPortrait {
    [self at_changeInterfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void)at_changeInterfaceOrientation:(enum UIInterfaceOrientation)interfaceOrientation {
    if([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&interfaceOrientation atIndex:2];
        [invocation invoke];
    }
}

@end
