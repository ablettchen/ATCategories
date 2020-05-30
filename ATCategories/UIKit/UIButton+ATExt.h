//
//  UIButton+ATExt.h
//  ATCategories
//
//  Created by ablett on 2019/5/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ATImagePositionType) {
    ATImagePositionTypeLeft,   //图片在左，标题在右，默认风格
    ATImagePositionTypeRight,  //图片在右，标题在左
    ATImagePositionTypeTop,    //图片在上，标题在下
    ATImagePositionTypeBottom  //图片在下，标题在上
};

typedef NS_ENUM(NSInteger, ATEdgeInsetsType) {
    ATEdgeInsetsTypeTitle,//标题
    ATEdgeInsetsTypeImage//图片
};

typedef NS_ENUM(NSInteger, ATMarginType) {
    ATMarginTypeTop         ,
    ATMarginTypeBottom      ,
    ATMarginTypeLeft        ,
    ATMarginTypeRight       ,
    ATMarginTypeTopLeft     ,
    ATMarginTypeTopRight    ,
    ATMarginTypeBottomLeft  ,
    ATMarginTypeBottomRight
};


@interface UIButton (ATExt)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意：1.该方法需在设置图片和标题之后才调用;
         2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *
 *  @param type    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 */
- (void)setImagePositionWithType:(ATImagePositionType)type spacing:(CGFloat)spacing;


- (void)setEdgeInsetsWithType:(ATEdgeInsetsType)edgeInsetsType marginType:(ATMarginType)marginType margin:(CGFloat)margin;

+ (instancetype)buttonWithTarget:(id)target action:(SEL)sel;

@end

NS_ASSUME_NONNULL_END
