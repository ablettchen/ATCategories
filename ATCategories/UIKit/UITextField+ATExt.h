//
//  UITextField+ATExt.h
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/26.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ATExt)

/**
 Set all text selected.
 */
- (void)selectAllText;

/**
 Set text in range selected.
 
 @param range  The range of selected text in a document.
 */
- (void)setSelectedRange:(NSRange)range;

/**
 *  当前的字符串
 */
@property (nonatomic, strong) NSMutableString  *currentString;

/**
 *  密码键盘的特殊处理（在代理方法 textFieldDidBeginEditing: 中调用）
 */
- (void)secureTextFieldDidBeginEditing;

/**
 *  获取当前显示字符串（在代理方法 textField:shouldChangeCharactersInRange:replacementString: 中调用）
 */
- (NSString *)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 *  添加AccessoryView
 *
 *  @param title 按钮标题
 */
- (void)addInputAccessoryViewButtonWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
