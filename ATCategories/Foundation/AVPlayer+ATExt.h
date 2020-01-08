//
//  AVPlayer+ATExt.h
//  ATCategories
//
//  Created by ablett on 2020/1/6.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayer (ATExt)

- (NSURL *)at_currentUrl;

@end

NS_ASSUME_NONNULL_END
