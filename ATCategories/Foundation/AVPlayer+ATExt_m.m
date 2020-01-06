//
//  AVPlayer+ATExt_m.m
//  ATCategories
//
//  Created by ablett on 2020/1/6.
//

#import "AVPlayer+ATExt_m.h"

@implementation AVPlayer (ATExt_m)

- (NSURL *)currentUrl {
    AVAsset *asset = self.currentItem.asset;
    if (![asset isKindOfClass:[AVURLAsset class]]) {return nil;}
    return [(AVURLAsset *)asset URL];
}

@end
