//
//  AVPlayer+ATExt.m
//  ATCategories
//
//  Created by ablett on 2020/1/6.
//

#import "AVPlayer+ATExt.h"

@implementation AVPlayer (ATExt)

- (NSURL *)currentUrl {
    AVAsset *asset = self.currentItem.asset;
    if (![asset isKindOfClass:[AVURLAsset class]]) {return nil;}
    return [(AVURLAsset *)asset URL];
}

@end
