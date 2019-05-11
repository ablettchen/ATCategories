//
//  UIButton+ATExt.m
//  ATCategories
//
//  Created by ablett on 2019/5/5.
//

#import "UIButton+ATExt.h"

@implementation UIButton (ATExt)

+ (instancetype)buttonWithTarget:(id)target action:(SEL)sel {
    id btn = [self buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setExclusiveTouch:YES];
    return btn;
}

@end
