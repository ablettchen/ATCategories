//
//  UITextField+ATExt.m
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/26.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import "UITextField+ATExt.h"
#import <objc/runtime.h>
#import "UIView+ATExt.h"
#import "ATCategoriesMacro.h"

@interface UITextField (ATExt)
@property (nonatomic) BOOL secureTextEntryBecomeActive;
@end

@implementation UITextField (ATExt)

- (void)selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


- (void)addInputAccessoryViewButtonWithTitle:(NSString *)title {

    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    inputAccessoryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95f];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.at_width = SCREEN_WIDTH;
    [button setTitle:title forState:UIControlStateNormal];
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 12.f);

    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [button addTarget:self action:@selector(resignFirstResponder)
     forControlEvents:UIControlEventTouchUpInside];
    [inputAccessoryView addSubview:button];
    
    self.inputAccessoryView = inputAccessoryView;
}

- (NSString *)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (string.length) {
        
        // 输入新字符状态
        self.currentString = [NSMutableString stringWithString:self.text.length <= 0 ? @"" : self.text];
        [self.currentString insertString:string atIndex:range.location];
        
        // 处理密码键盘的特殊情况
        if (self.secureTextEntryBecomeActive == YES && self.secureTextEntry == YES) {
            
            self.currentString               = [NSMutableString stringWithString:string];
            self.secureTextEntryBecomeActive = NO;
        }
        
    } else {
        
        // 删除字符状态
        if (self.text.length >= 1) {
            
            self.currentString = [NSMutableString stringWithString:self.text.length <= 0 ? @"" : self.text];
            [self.currentString deleteCharactersInRange:range];
        }
        
        // 处理密码键盘的特殊情况
        if (self.secureTextEntryBecomeActive == YES && self.secureTextEntry == YES) {
            
            self.currentString               = [NSMutableString stringWithFormat:@""];
            self.secureTextEntryBecomeActive = NO;
        }
    }
    
    return [NSString stringWithString:self.currentString.length <= 0 ? @"" : self.currentString];
}

- (void)secureTextFieldDidBeginEditing {

    // 处理密码键盘的特殊情况
    if (self.secureTextEntry == YES) {
        
        self.secureTextEntryBecomeActive = YES;
    }
}

#pragma mark - 添加的属性

- (void)setSecureTextEntryBecomeActive:(BOOL)secureTextEntryBecomeActive {

    objc_setAssociatedObject(self, @selector(secureTextEntryBecomeActive), [NSNumber numberWithBool:secureTextEntryBecomeActive], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)secureTextEntryBecomeActive {

    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCurrentString:(NSMutableString *)currentString {

    objc_setAssociatedObject(self, @selector(currentString), currentString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableString *)currentString {

    return objc_getAssociatedObject(self, _cmd);
}



@end
