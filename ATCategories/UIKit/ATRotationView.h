//
//  ATRotationView.h
//  ATCategories
//
//  Created by ablett on 2019/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATRotationView : UIView

@property (nonatomic) NSTimeInterval  speed;    ///< How many seconds to rotate 1 π (s/π).
@property (nonatomic) BOOL clockWise;           ///< Direction of rotation, default is YES.
@property (nonatomic) CGFloat startAngle;       ///< Start angle.

/** Start rotate animation. */
- (void)startRotateAnimation;

/**  Stop and reset animation. */
- (void)reset;

@end

NS_ASSUME_NONNULL_END
