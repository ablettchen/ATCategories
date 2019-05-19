//
//  NSBundle+ATExt.m
//  ATCategories
//  https://github.com/ablettchen/ATCategories
//
//  Created by ablett on 2018/11/26.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import "NSBundle+ATExt.h"
#import "NSString+ATExt.h"

@implementation NSBundle (ATExt)

+ (NSArray *)preferredScales {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

+ (NSString *)pathForScaledResource:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)bundlePath {
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return [self pathForResource:name ofType:ext inDirectory:bundlePath];
    
    NSString *path = nil;
    NSArray *scales = [self preferredScales];
    for (int s = 0; s < scales.count; s++) {
        CGFloat scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = ext.length ? [name stringByAppendingNameScale:scale]
        : [name stringByAppendingPathScale:scale];
        path = [self pathForResource:scaledName ofType:ext inDirectory:bundlePath];
        if (path) break;
    }
    
    return path;
}

- (NSString *)pathForScaledResource:(NSString *)name ofType:(NSString *)ext {
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return [self pathForResource:name ofType:ext];
    
    NSString *path = nil;
    NSArray *scales = [NSBundle preferredScales];
    for (int s = 0; s < scales.count; s++) {
        CGFloat scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = ext.length ? [name stringByAppendingNameScale:scale]
        : [name stringByAppendingPathScale:scale];
        path = [self pathForResource:scaledName ofType:ext];
        if (path) break;
    }
    
    return path;
}

- (NSString *)pathForScaledResource:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath {
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return [self pathForResource:name ofType:ext];
    
    NSString *path = nil;
    NSArray *scales = [NSBundle preferredScales];
    for (int s = 0; s < scales.count; s++) {
        CGFloat scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = ext.length ? [name stringByAppendingNameScale:scale]
        : [name stringByAppendingPathScale:scale];
        path = [self pathForResource:scaledName ofType:ext inDirectory:subpath];
        if (path) break;
    }
    
    return path;
}

+ (instancetype)at_bundleForClass:(Class)aClass resource:(nullable NSString *)name ofType:(nullable NSString *)ext {
    NSString *path = [[NSBundle bundleForClass:aClass] pathForResource:name ofType:ext];
    return [NSBundle bundleWithPath:path];
}

- (nullable UIImage *)at_imageNamed:(nullable NSString *)name {
    if (!name || name.length == 0) {return nil;}
    UIImage *image = \
    [[UIImage imageWithContentsOfFile:[self pathForResource:[NSString stringWithFormat:@"%@@2x", name] ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

- (NSString *)at_localizedStringForKey:(nullable NSString *)key {
    return [self at_localizedStringForKey:key language:nil];
}

- (NSString *)at_localizedStringForKey:(nullable NSString *)key
                              language:(nullable NSString *)language {
    return [self at_localizedStringForKey:key value:nil language:language];
}

- (NSString *)at_localizedStringForKey:(nullable NSString *)key
                                 value:(nullable NSString *)value
                              language:(nullable NSString *)language {
    if (!language) {language = [NSLocale preferredLanguages].firstObject;}
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    }else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        }
    }else {
        language = @"en";
    }
    NSBundle *bundle = [NSBundle bundleWithPath:[self pathForResource:language ofType:@"lproj"]];
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

@end
